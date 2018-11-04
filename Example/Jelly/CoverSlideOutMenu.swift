import UIKit
import Jelly

class CoverSlideOutMenu: UIViewController {
    var animator: Animator?
    var viewControllerToPresent: UIViewController?
    
    @IBAction func didPressShowButton(_ sender: Any) {
        present(viewControllerToPresent!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.isNavigationBarHidden = true
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 20, backgroundStyle: .blurred(effectStyle: .dark), isTapBackgroundToDismissEnabled: true)
        let size = PresentationSize(width: .fullscreen, height: .halfscreen)
        let interaction = InteractionConfiguration(completionThreshold: 0.5, dragMode: .canvas)
        let alignment = PresentationAlignment(vertical: .top, horizontal: .center)
        let presentation = CoverPresentation(directionShow: .top,
                                             directionDismiss: .top,
                                             uiConfiguration: uiConfiguration,
                                             size: size,
                                             alignment: alignment,
                                             marginGuards: UIEdgeInsets(top: 60, left: 16, bottom: 120, right: 16),
                                             interactionConfiguration: interaction)
        let animator = Animator(presentation: presentation)
        viewControllerToPresent = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PresentMe")
        animator.prepare(presentedViewController: viewControllerToPresent!, presentingViewController: self)
        self.animator = animator
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

struct SizeProvider: PresentationSizeProvider {
    var presentationSize: PresentationSizeProtocol = PresentationSize(width: .fullscreen, height: .fullscreen)
}
