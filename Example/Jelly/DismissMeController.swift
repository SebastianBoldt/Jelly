//
//  Jelly-Animators
//  Created by Sebastian Boldt on 17.11.16.

import UIKit

class DismissMeController: UIViewController {
    var interactionAction: (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        if let interactionAction = interactionAction {
            interactionAction()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
