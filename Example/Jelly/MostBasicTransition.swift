import UIKit
import Jelly

class MostBasicTransition: UIViewController {
    var animator: Animator?
    
    @IBAction func didPressShowButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe")
        let presentation = SlidePresentation(direction: .right, size: .halfscreen)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: viewControllerToPresent)
        self.animator = animator
        
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
