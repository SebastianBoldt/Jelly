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
        
        //TODO: Corner Radius not working properly
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 20, backgroundStyle: .blurred(effectStyle: .light), isTapBackgroundToDismissEnabled: true)
        let interaction = InteractionConfiguration(completionThreshold: 0.5, dragMode: .edge)
        let presentation = SlidePresentation(uiConfiguration: uiConfiguration, direction: .right, width: .fullscreen, spring: .none, interactionConfiguration: interaction)
        let animator = Animator(presentation: presentation)
        viewControllerToPresent = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PresentMe")
        animator.prepare(presentedViewController: viewControllerToPresent!, presentingViewController: self)
        self.animator = animator
        self.view.isUserInteractionEnabled = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

