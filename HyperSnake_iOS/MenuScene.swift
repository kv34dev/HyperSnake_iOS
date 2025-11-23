import SpriteKit

class MenuScene: SKScene {
    
    let snakeColors: [UIColor] = [
        UIColor(red: 1, green: 0.27, blue: 0.27, alpha: 1),   // Red
        UIColor(red: 0.22, green: 1, blue: 0.08, alpha: 1),   // Green
        UIColor(red: 0.71, green: 0.35, blue: 1, alpha: 1),   // Purple
        UIColor(red: 1, green: 0.59, blue: 0.23, alpha: 1),   // Orange
        UIColor.cyan,                                         // Cyan
        UIColor(red: 1, green: 0.39, blue: 0.78, alpha: 1),   // Pink
        UIColor(red: 1, green: 0.88, blue: 0.31, alpha: 1),   // Yellow
        UIColor(red: 0, green: 0.47, blue: 1, alpha: 1),      // Blue
        UIColor.white                                         // White
    ]

    
    let difficulties: [String] = ["Easy", "Normal", "Hard"]
    let difficultySpeeds: [CGFloat] = [0.50, 0.20, 0.10]
    
    var chosenColor = UIColor.green
    var chosenSpeed: CGFloat = 0.14
    var chosenDifficultyIndex = 1
    
    var colorBoxes: [SKShapeNode] = []
    var difficultyLabels: [SKLabelNode] = []
    var difficultyUnderlines: [SKShapeNode] = []
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.07, alpha: 1)
        
        let title = SKLabelNode(text: "HyperSnake")
        title.fontName = "Arial-BoldMT"
        title.fontSize = 62
        title.position = CGPoint(x: size.width/2, y: size.height - 120)
        addChild(title)
        
        drawColorButtons()
        drawDifficultyButtons()
        drawStartButton()
        
        highlightSelectedColor()
        highlightSelectedDifficulty()
    }
    
    //MARK: colors
    func drawColorButtons() {
        colorBoxes.removeAll()
        
        let rows = 3
        let columns = 3
        
        let boxWidth: CGFloat = 80
        let boxHeight: CGFloat = 80
        let spacing: CGFloat = 30
        
        let totalWidth = CGFloat(columns) * boxWidth + CGFloat(columns - 1) * spacing
        let totalHeight = CGFloat(rows) * boxHeight + CGFloat(rows - 1) * spacing
        
        let startX = (size.width - totalWidth) / 2 + boxWidth/2
        let startY = size.height - 230  // высота
        
        for i in 0..<snakeColors.count {
            let col = i % columns
            let row = i / columns
            
            let x = startX + CGFloat(col) * (boxWidth + spacing)
            let y = startY - CGFloat(row) * (boxHeight + spacing)
            
            let box = SKShapeNode(rectOf: CGSize(width: boxWidth, height: boxHeight), cornerRadius: 14)
            box.fillColor = snakeColors[i]
            box.strokeColor = .clear
            box.lineWidth = 5
            box.position = CGPoint(x: x, y: y)
            box.name = "color_\(i)"
            addChild(box)
            colorBoxes.append(box)
        }
    }
    
    func highlightSelectedColor() {
        for (i, box) in colorBoxes.enumerated() {
            box.strokeColor = (snakeColors[i] == chosenColor) ? .white : .clear
        }
    }
    
    //MARK: dificulty
    func drawDifficultyButtons() {
        difficultyLabels.removeAll()
        difficultyUnderlines.removeAll()
        
        let spacing: CGFloat = 45
        var y = size.height/2 - 130   //высота
        
        for i in 0..<difficulties.count {
            let label = SKLabelNode(text: difficulties[i])
            label.fontName = "Arial"
            label.fontSize = 26
            label.position = CGPoint(x: size.width/2, y: y)
            label.name = "diff_\(i)"
            addChild(label)
            difficultyLabels.append(label)
            
            let underline = SKShapeNode(rectOf: CGSize(width: label.frame.width, height: 3))
            underline.fillColor = .white
            underline.strokeColor = .clear
            underline.position = CGPoint(x: size.width/2, y: y - 5)
            addChild(underline)
            difficultyUnderlines.append(underline)
            
            y -= spacing
        }
    }
    
    func highlightSelectedDifficulty() {
        for (i, underline) in difficultyUnderlines.enumerated() {
            underline.isHidden = (i != chosenDifficultyIndex)
        }
    }
    
    //MARK: START
    func drawStartButton() {
        let btn = SKShapeNode(rectOf: CGSize(width: 240, height: 70), cornerRadius: 20)
        btn.fillColor = UIColor(red: 0.27, green: 0.55, blue: 1.0, alpha: 1)
        btn.position = CGPoint(x: size.width/2, y: 120)
        btn.name = "start"
        addChild(btn)
        
        let text = SKLabelNode(text: "START")
        text.fontName = "Arial-BoldMT"
        text.fontSize = 30
        text.position = CGPoint(x: 0, y: -10)
        text.name = "start"
        btn.addChild(text)
    }
    
    //touch
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let t = touches.first else { return }
        let loc = t.location(in: self)
        let tapped = nodes(at: loc)
        
        for node in tapped {
            
            if node.name?.starts(with: "color_") == true {
                let index = Int(node.name!.split(separator: "_")[1])!
                chosenColor = snakeColors[index]
                highlightSelectedColor()
            }
            
            if node.name?.starts(with: "diff_") == true {
                let index = Int(node.name!.split(separator: "_")[1])!
                chosenDifficultyIndex = index
                chosenSpeed = difficultySpeeds[index]
                highlightSelectedDifficulty()
            }
            
            if node.name == "start" {
                let game = GameScene(size: size, snakeColor: chosenColor, speed: chosenSpeed)
                game.scaleMode = .resizeFill
                view?.presentScene(game, transition: .fade(withDuration: 0.3))
            }
        }
    }
}
