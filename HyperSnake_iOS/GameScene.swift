import SpriteKit

class GameScene: SKScene {
    
    var snake: [(Int, Int)] = []
    var direction = (x: 1, y: 0)
    var cellSize = 25
    var speedValue = 7
    var tickTime: TimeInterval = 0
    
    var food: (Int, Int)?
    var score = 0
    
    var snakeColor = UIColor.green
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let t = touches.first else { return }
        let start = t.previousLocation(in: self)
        let end = t.location(in: self)
        
        let dx = end.x - start.x
        let dy = end.y - start.y
        
        if abs(dx) > abs(dy) {
            if dx > 0 { setDirection(dx: 1, dy: 0) }
            else { setDirection(dx: -1, dy: 0) }
        } else {
            if dy > 0 { setDirection(dx: 0, dy: 1) }
            else { setDirection(dx: 0, dy: -1) }
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 28/255, alpha: 1)
        
        score = 0
        tickTime = 0
        
        snake = [(350, 350)]
        
        spawnFood()
    }
    
    func spawnFood() {
        let x = Int.random(in: 0..<28) * cellSize
        let y = Int.random(in: 0..<28) * cellSize
        food = (x,y)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if currentTime - tickTime < (0.1 * (7.0 / Double(speedValue))) { return }
        tickTime = currentTime
        
        moveSnake()
        draw()
    }
    
    func moveSnake() {
        guard let head = snake.first else { return }
        
        let newHead = (
            head.0 + direction.x * cellSize,
            head.1 + direction.y * cellSize
        )
        
        // Столкновения
        if newHead.0 < 0 || newHead.0 >= 700 ||
           newHead.1 < 0 || newHead.1 >= 700 ||
           snake.contains(where: { $0 == newHead }) {
            gameOver()
            return
        }
        
        snake.insert((newHead.0, newHead.1), at: 0)
        
        // Еда
        if let f = food, f.0 == newHead.0 && f.1 == newHead.1 {
            score += 1
            spawnFood()
        } else {
            snake.removeLast()
        }
    }
    
    func draw() {
        removeAllChildren()
        
        // Еда
        if let f = food {
            let foodNode = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize), cornerRadius: 5)
            foodNode.fillColor = .red
            foodNode.position = CGPoint(x: f.0, y: f.1)
            addChild(foodNode)
        }
        
        // Змейка
        for seg in snake {
            let node = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize), cornerRadius: 6)
            node.fillColor = snakeColor
            node.position = CGPoint(x: seg.0, y: seg.1)
            addChild(node)
        }
    }
    
    func gameOver() {
        let gameOverLabel = SKLabelNode(text: "GAME OVER")
        gameOverLabel.fontSize = 48
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: 350, y: 350)
        addChild(gameOverLabel)
        
        isPaused = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.view?.presentScene(MenuScene(size: self.size),
                transition: SKTransition.fade(withDuration: 0.5))
        }
    }
    
    func setDirection(dx: Int, dy: Int) {
        if dx != -direction.x || dy != -direction.y {
            direction = (dx, dy)
        }
    }
}
