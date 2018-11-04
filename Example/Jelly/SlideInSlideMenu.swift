import UIKit
import Jelly

class SlideInSlideMenu: UIViewController {
    var animator: Animator?
    var viewControllerToPresent: UIViewController?
    
    @IBAction func didPressShowButton(_ sender: Any) {
        present(viewControllerToPresent!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        navigationController?.isNavigationBarHidden = true
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 20, backgroundStyle: .blurred(effectStyle: .light), isTapBackgroundToDismissEnabled: true)
        let interaction = InteractionConfiguration(completionThreshold: 0.5, dragMode: .canvas)
        let presentation = SlidePresentation(uiConfiguration: uiConfiguration, direction: .bottom, width: .halfscreen, spring: .none, interactionConfiguration: interaction)
        let animator = Animator(presentation: presentation)
        viewControllerToPresent = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PresentMe")
        animator.prepare(presentedViewController: viewControllerToPresent!, presentingViewController: self)
        self.animator = animator
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

