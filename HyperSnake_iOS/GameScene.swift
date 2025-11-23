import SpriteKit

class GameScene: SKScene {
    
    let cell: CGFloat = 25
    var snake: [CGPoint] = []
    var direction = CGVector(dx: 25, dy: 0)
    var food: SKShapeNode!
    
    var snakeColor: UIColor
    var moveDelay: CGFloat
    var lastMove: TimeInterval = 0
    
    var score = 0
    var scoreLabel = SKLabelNode()
    var gameOver = false
    
    init(size: CGSize, snakeColor: UIColor, speed: CGFloat) {
        self.snakeColor = snakeColor
        self.moveDelay = speed
        super.init(size: size)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.11, alpha: 1)
        
        scoreLabel.fontName = "Arial-BoldMT"
        scoreLabel.fontSize = 32
        scoreLabel.position = CGPoint(x: 80, y: size.height - 90)
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
        
        let startX = round((size.width / 2) / cell) * cell
        let startY = round((size.height / 2) / cell) * cell
        
        snake = [CGPoint(x: startX, y: startY)]
        
        spawnFood()
    }
    
    func spawnFood() {
        food?.removeFromParent()
        
        let cols = Int(size.width / cell)
        let rows = Int(size.height / cell)
        
        let fx = CGFloat(Int.random(in: 0..<cols)) * cell
        let fy = CGFloat(Int.random(in: 0..<rows)) * cell
        
        food = SKShapeNode(rectOf: CGSize(width: cell, height: cell), cornerRadius: 6)
        food.fillColor = UIColor(red: 1, green: 0.27, blue: 0.27, alpha: 1)
        food.position = CGPoint(x: fx, y: fy)
        addChild(food)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameOver { return }
        
        if currentTime - lastMove >= moveDelay {
            lastMove = currentTime
            moveSnake()
        }
    }
    
    func moveSnake() {
        let head = snake.first!
        let newHead = CGPoint(x: head.x + direction.dx,
                              y: head.y + direction.dy)
        
        if newHead.x < 0 || newHead.y < 0 ||
            newHead.x >= size.width || newHead.y >= size.height {
            endGame()
            return
        }
        
        if snake.contains(newHead) {
            endGame()
            return
        }
        
        snake.insert(newHead, at: 0)
        
        if newHead.x == food.position.x &&
            newHead.y == food.position.y {
            
            score += 1
            scoreLabel.text = "Score: \(score)"
            spawnFood()
            
        } else {
            snake.removeLast()
        }
        
        redrawSnake()
    }
    
    func redrawSnake() {
        removeChildren(in: children.filter { $0.name == "snakepart" })
        
        for part in snake {
            let n = SKShapeNode(rectOf: CGSize(width: cell, height: cell), cornerRadius: 6)
            n.position = part
            n.fillColor = snakeColor
            n.name = "snakepart"
            addChild(n)
        }
    }
    
    func endGame() {
        gameOver = true
        
        let label = SKLabelNode(text: "GAME OVER")
        label.fontName = "Arial-BoldMT"
        label.fontSize = 52
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        let restart = SKLabelNode(text: "Tap to Restart")
        restart.fontName = "Arial"
        restart.fontSize = 26
        restart.position = CGPoint(x: size.width/2, y: size.height/2 - 60)
        restart.name = "restart"
        addChild(restart)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameOver {
            let menu = MenuScene(size: size)
            view?.presentScene(menu, transition: .fade(withDuration: 0.3))
            return
        }
        
        guard let t = touches.first else { return }
        let loc = t.location(in: self)
        
        let head = snake.first!
        
        if abs(loc.x - head.x) > abs(loc.y - head.y) {
            direction = loc.x > head.x ? CGVector(dx: cell, dy: 0)
                                       : CGVector(dx: -cell, dy: 0)
        } else {
            direction = loc.y > head.y ? CGVector(dx: 0, dy: cell)
                                       : CGVector(dx: 0, dy: -cell)
        }
    }
}
