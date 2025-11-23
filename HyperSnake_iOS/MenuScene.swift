import SpriteKit

class MenuScene: SKScene {

    let snakeColors: [(name: String, color: UIColor)] = [
        ("Red", UIColor(red: 1, green: 0.27, blue: 0.27, alpha: 1)),
        ("Orange", UIColor(red: 1, green: 0.6, blue: 0.23, alpha: 1)),
        ("Yellow", UIColor(red: 1, green: 0.88, blue: 0.31, alpha: 1)),
        ("Green", UIColor(red: 0.22, green: 1, blue: 0.08, alpha: 1)),
        ("Cyan", UIColor.cyan),
        ("Blue", UIColor(red: 0, green: 0.47, blue: 1, alpha: 1)),
        ("Purple", UIColor(red: 0.7, green: 0.35, blue: 1, alpha: 1)),
        ("Pink", UIColor(red: 1, green: 0.39, blue: 0.78, alpha: 1)),
        ("White", UIColor(white: 0.93, alpha: 1))
    ]

    let difficulties: [(name: String, speed: Int)] = [
        ("Easy", 5),
        ("Normal", 7),
        ("Hard", 15)
    ]

    var selectedColor = UIColor.green
    var selectedSpeed = 7

    override func didMove(to view: SKView) {

        backgroundColor = UIColor(red: 14/255, green: 14/255, blue: 18/255, alpha: 1)

        createTitle()
        createColorCard()
        createDifficultyCard()
        createStartButton()
    }

    // TITLE — "HyperSnake"
    func createTitle() {
        let label = SKLabelNode(text: "HyperSnake")
        label.fontName = "ArialRoundedMTBold"
        label.fontSize = 64
        label.position = CGPoint(x: size.width/2, y: size.height - 160)
        label.fontColor = UIColor(white: 0.94, alpha: 1)
        addChild(label)
    }

    // COLOR CARD
    func createColorCard() {

        let card = SKShapeNode(rectOf: CGSize(width: size.width - 120, height: 200), cornerRadius: 20)
        card.fillColor = UIColor(red: 0.12, green: 0.12, blue: 0.14, alpha: 1)
        card.strokeColor = .clear
        card.position = CGPoint(x: size.width/2, y: size.height - 350)
        addChild(card)

        let title = SKLabelNode(text: "Snake Color")
        title.fontName = "ArialRoundedMTBold"
        title.fontSize = 32
        title.fontColor = .white
        title.position = CGPoint(x: 0, y: 70)
        card.addChild(title)

        let cols = 4
        let rows = 3
        let cellW: CGFloat = 140
        let cellH: CGFloat = 50

        for (i, item) in snakeColors.enumerated() {

            let col = i % cols
            let row = i / cols

            let x = -((cellW * CGFloat(cols-1)) / 2) + CGFloat(col) * cellW
            let y = 20 - CGFloat(row) * cellH

            // квадрат цвета
            let box = SKShapeNode(rectOf: CGSize(width: 35, height: 35), cornerRadius: 8)
            box.position = CGPoint(x: x, y: y)
            box.fillColor = item.color
            box.name = "color_\(item.name)"
            card.addChild(box)

            // рамка если выбран
            if item.color == selectedColor {
                let outline = SKShapeNode(rectOf: CGSize(width: 38, height: 38), cornerRadius: 8)
                outline.strokeColor = .white
                outline.lineWidth = 3
                outline.position = box.position
                card.addChild(outline)
            }

            // текст цвета
            let label = SKLabelNode(text: item.name)
            label.fontName = "Arial"
            label.fontSize = 26
            label.horizontalAlignmentMode = .left
            label.fontColor = UIColor(white: 0.9, alpha: 1)
            label.position = CGPoint(x: x + 30, y: y - 10)
            addChild(label)
        }
    }

    // DIFFICULTY CARD
    func createDifficultyCard() {

        let card = SKShapeNode(rectOf: CGSize(width: size.width - 120, height: 200), cornerRadius: 20)
        card.fillColor = UIColor(red: 0.12, green: 0.12, blue: 0.14, alpha: 1)
        card.strokeColor = .clear
        card.position = CGPoint(x: size.width/2, y: size.height - 600)
        addChild(card)

        let title = SKLabelNode(text: "Difficulty")
        title.fontName = "ArialRoundedMTBold"
        title.fontSize = 32
        title.fontColor = .white
        title.position = CGPoint(x: 0, y: 70)
        card.addChild(title)

        var y: CGFloat = 20

        for item in difficulties {
            let label = SKLabelNode(text: item.name)
            label.fontName = "Arial"
            label.fontSize = 26
            label.fontColor = .white
            label.position = CGPoint(x: 0, y: y)
            label.name = "diff_\(item.name)"
            card.addChild(label)

            if item.speed == selectedSpeed {
                let underline = SKShapeNode(rectOf: CGSize(width: 120, height: 3))
                underline.fillColor = .white
                underline.position = CGPoint(x: 0, y: y - 18)
                card.addChild(underline)
            }

            y -= 50
        }
    }

    // START BUTTON
    func createStartButton() {
        let rect = SKShapeNode(rectOf: CGSize(width: 240, height: 65), cornerRadius: 20)
        rect.fillColor = UIColor(red: 0.27, green: 0.57, blue: 1, alpha: 1)
        rect.position = CGPoint(x: size.width/2, y: 140)
        rect.name = "START"
        addChild(rect)

        let label = SKLabelNode(text: "START")
        label.fontName = "ArialRoundedMTBold"
        label.fontSize = 30
        label.fontColor = .white
        label.position = CGPoint.zero
        rect.addChild(label)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let t = touches.first else { return }
        let loc = t.location(in: self)

        let node = nodes(at: loc).first

        if let name = node?.name {
            if name.starts(with: "color_") {
                let colorName = String(name.dropFirst(6))
                if let color = snakeColors.first(where: {$0.name == colorName})?.color {
                    selectedColor = color
                    view?.presentScene(MenuScene(size: size))
                }
            }

            if name.starts(with: "diff_") {
                let diff = String(name.dropFirst(5))
                if let spd = difficulties.first(where: {$0.name == diff})?.speed {
                    selectedSpeed = spd
                    view?.presentScene(MenuScene(size: size))
                }
            }

            if name == "START" {
                let game = GameScene(size: size)
                game.snakeColor = selectedColor
                game.speedValue = selectedSpeed
                view?.presentScene(game,
                    transition: SKTransition.fade(withDuration: 0.5))
            }
        }
    }
}
