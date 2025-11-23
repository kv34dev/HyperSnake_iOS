import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as? SKView {
            let scene = MenuScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
        }
    }

    override var prefersStatusBarHidden: Bool { true }
}
