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

        //TODO: Corner Radius not working properly
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 20, backgroundStyle: .blurred(effectStyle: .light), isTapBackgroundToDismissEnabled: true)
        let size = PresentationSize(width: .halfscreen, height: .halfscreen)
        let interaction = InteractionConfiguration(completionThreshold: 0.5, dragMode: .canvas)
        let alignment = PresentationAlignment(vertical: .center, horizontal: .center)
        let presentation = CoverPresentation(directionShow: .left,
                                             directionDismiss: .right,
                                             uiConfiguration: uiConfiguration,
                                             size: size,
                                             alignment: alignment,
                                             marginGuards: UIEdgeInsets(top: 40, left: 8, bottom: 40, right: 8),
                                             interactionConfiguration: interaction)
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

struct SizeProvider: PresentationSizeProvider {
    var presentationSize: PresentationSizeProtocol = PresentationSize(width: .fullscreen, height: .fullscreen)
}
