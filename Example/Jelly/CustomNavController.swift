import UIKit
import TouchVisualizer

class CustomNav: UINavigationController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        
        var config = Configuration()
        config.color = .lightGray
        config.showsTouchRadius = true
        config.defaultSize = CGSize(width: 100, height: 100)
        Visualizer.start(config)
    }
}
