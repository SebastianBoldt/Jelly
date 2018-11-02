import UIKit
import Jelly

class InteractiveSlideOutViewController: UIViewController {
    var animator: Animator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true

        //TODO: Corner Radius not working properly
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 20, backgroundStyle: .blurred(effectStyle: .dark), isTapBackgroundToDismissEnabled: true)
        let size = PresentationSize(width: .halfscreen, height: .fullscreen)
        let interaction = InteractionConfiguration(completionThreshold: 0.5, dragMode: .edge)
        let alignment = PresentationAlignment(vertical: .top, horizontal: .left)
        let presentation = CoverPresentation(directionShow: .left,
                                             directionDismiss: .left,
                                             uiConfiguration: uiConfiguration,
                                             size: size,
                                             alignment: alignment,
                                             marginGuards: UIEdgeInsets(top: 40, left: 8, bottom: 40, right: 8),
                                             interactionConfiguration: interaction)
        let animator = Animator(presentation: presentation)
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PresentMe")
        animator.prepare(presentedViewController: viewController, presentingViewController: self)
        self.animator = animator
        self.view.isUserInteractionEnabled = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
