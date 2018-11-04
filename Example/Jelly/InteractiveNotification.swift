import UIKit
import Jelly

class InteractiveNotification: UIViewController {
    var animator: Animator?
    var viewControllerToPresent: UIViewController?
    
    @IBAction func didPressShowButton(_ sender: Any) {
        present(viewControllerToPresent!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 20, backgroundStyle: .blurred(effectStyle: .light))
        let interactionConfig = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .canvas)
        let size = PresentationSize(width: .fullscreen, height: .custom(value: 300))
        let alignment = PresentationAlignment(vertical: .top, horizontal: .center)
        let margin = UIEdgeInsets(top: 40, left: 16, bottom: 0, right: 16)
        let presentation = CoverPresentation(directionShow: .top, directionDismiss: .top, uiConfiguration: uiConfiguration, size: size, alignment: alignment, marginGuards: margin, interactionConfiguration: interactionConfig)
        
        let animator = Animator(presentation: presentation)
        viewControllerToPresent = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PresentMe")
        animator.prepare(presentedViewController: viewControllerToPresent!)
        self.animator = animator
        self.view.isUserInteractionEnabled = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
