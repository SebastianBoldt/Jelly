import UIKit
import Jelly

class MainViewController: UIViewController {
    var animator: Animator?
    var type: ExampleType?
    var showButtonLogic: (() -> Void)?
    
    @IBAction func didPressShowButton(_ sender: Any) {
        showButtonLogic?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        modalPresentationCapturesStatusBarAppearance = true
        setup()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setup() {
        guard let type = type else {
            return
        }
        
        switch type {
            case .nonInteractive(let nonInteractiveType):
                switch nonInteractiveType {
                    case .coverFromBottom:
                        showButtonLogic = {
                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe")
                            let marginGuards = UIEdgeInsets(top: 0, left: 16, bottom: 32, right: 16)
                            let uiConfiguration = PresentationUIConfiguration(cornerRadius: 10, backgroundStyle: .dimmed(alpha: 0.5), isTapBackgroundToDismissEnabled: true, corners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
                            let size = PresentationSize(width: .fullscreen, height: .halfscreen)
                            let alignment = PresentationAlignment(vertical: .bottom, horizontal: .center)
                            let presentation = CoverPresentation(directionShow: .bottom, directionDismiss: .bottom, uiConfiguration: uiConfiguration, size: size, alignment: alignment, marginGuards: marginGuards)
                            let animator = Animator(presentation: presentation)
                            animator.prepare(presentedViewController: viewControllerToPresent)
                            self.animator = animator
                            self.present(viewControllerToPresent, animated: true, completion: nil)
                        }
                    case .slideFromRight:
                        showButtonLogic = {
                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe")
                            let presentation = SlidePresentation(direction: .right, size: .halfscreen)
                            let animator = Animator(presentation: presentation)
                            animator.prepare(presentedViewController: viewControllerToPresent)
                            self.animator = animator
                            self.present(viewControllerToPresent, animated: true, completion: nil)
                        }
                }
            case .interactive(let interactiveType):
                switch interactiveType {
                    case .coverMenuFromRightCanvas:()
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe")
                        let interactionConfiguration = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .canvas)
                        let uiConfiguration = PresentationUIConfiguration(backgroundStyle: .blurred(effectStyle: .light))
                        let size = PresentationSize(width: .halfscreen, height: .fullscreen)
                        let alignment = PresentationAlignment(vertical: .center, horizontal: .left)
                        let presentation = CoverPresentation(directionShow: .left, directionDismiss: .left, uiConfiguration: uiConfiguration, size: size, alignment: alignment, interactionConfiguration: interactionConfiguration)
                        let animator = Animator(presentation: presentation)
                        animator.prepare(presentedViewController: viewControllerToPresent)
                        self.animator = animator
                    
                        showButtonLogic = {
                            self.present(viewControllerToPresent, animated: true, completion: nil)
                        }
                    case .slideMenuFromRightEdge:
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe")
                        let interactionConfiguration = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .edge)
                        let uiConfiguration = PresentationUIConfiguration(backgroundStyle: .dimmed(alpha: 0.5))
                        let presentation = SlidePresentation(uiConfiguration: uiConfiguration, direction: .right, size: .fullscreen, interactionConfiguration: interactionConfiguration)
                        let animator = Animator(presentation: presentation)
                        animator.prepare(presentedViewController: viewControllerToPresent)
                        self.animator = animator
                        
                        showButtonLogic = {
                            self.present(viewControllerToPresent, animated: true, completion: nil)
                        }
                    case .multipleDirectionsCoverCanvas:
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe")
                        let interactionConfiguration = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .canvas)
                        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 10, backgroundStyle: .blurred(effectStyle: .light))
                        let size = PresentationSize(width: .fullscreen, height: .halfscreen)
                        let marginGuards = UIEdgeInsets(top: 50, left: 16, bottom: 50, right: 16)
                        let alignment = PresentationAlignment(vertical: .center, horizontal: .center)
                        let presentation = CoverPresentation(directionShow: .left, directionDismiss: .right, uiConfiguration: uiConfiguration, size: size, alignment: alignment, marginGuards: marginGuards, interactionConfiguration: interactionConfiguration)
                        let animator = Animator(presentation: presentation)
                        animator.prepare(presentedViewController: viewControllerToPresent)
                        self.animator = animator
                        
                        showButtonLogic = {
                            self.present(viewControllerToPresent, animated: true, completion: nil)
                        }
                    case .notificationFromTopCanvas:
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe")
                        let interactionConfiguration = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .canvas)
                        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 10, backgroundStyle: .dimmed(alpha: 0.5))
                        let size = PresentationSize(width: .fullscreen, height: .custom(value: 200))
                        let marginGuards = UIEdgeInsets(top: 50, left: 16, bottom: 8, right: 16)
                        let alignment = PresentationAlignment(vertical: .top, horizontal: .center)
                        let presentation = CoverPresentation(directionShow: .top, directionDismiss: .top, uiConfiguration: uiConfiguration, size: size, alignment: alignment, marginGuards: marginGuards, interactionConfiguration: interactionConfiguration)
                        let animator = Animator(presentation: presentation)
                        animator.prepare(presentedViewController: viewControllerToPresent)
                        self.animator = animator
                        
                        showButtonLogic = {
                            self.present(viewControllerToPresent, animated: true, completion: nil)
                    }
                    
                }
            case .liveUpdate(let liveUpdateType):
                switch liveUpdateType {
                    case .updateAlignment:()
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe") as! DismissMeController
                        let alignment = PresentationAlignment(vertical: .top, horizontal: .center)
                        let uiConfig = PresentationUIConfiguration(cornerRadius: 10)
                        let marginGuards = UIEdgeInsets(top: 50, left: 16, bottom: 50, right: 16)
                        let presentation = CoverPresentation(directionShow: .top, directionDismiss: .top, uiConfiguration: uiConfig, size: PresentationSize(width: .fullscreen, height: .halfscreen), alignment: alignment, marginGuards: marginGuards)
                        let animator = Animator(presentation: presentation)
                        animator.prepare(presentedViewController: viewControllerToPresent)
                        self.animator = animator
                    
                        showButtonLogic = { [weak self] in
                            self?.present(viewControllerToPresent, animated: true, completion: nil)
                        }
                    
                        viewControllerToPresent.interactionAction = { [weak self] in
                            try! self?.animator?.updateVerticalAlignment(alignment: .bottom, duration: .medium)
                        }
                    case .updateSize:()
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe") as! DismissMeController
                        let alignment = PresentationAlignment(vertical: .top, horizontal: .center)
                        let uiConfig = PresentationUIConfiguration(cornerRadius: 10)
                        let marginGuards = UIEdgeInsets(top: 50, left: 16, bottom: 50, right: 16)
                        let presentation = CoverPresentation(directionShow: .top, directionDismiss: .top, uiConfiguration: uiConfig, size: PresentationSize(width: .fullscreen, height: .halfscreen), alignment: alignment, marginGuards: marginGuards)
                        let animator = Animator(presentation: presentation)
                        animator.prepare(presentedViewController: viewControllerToPresent)
                        self.animator = animator
                    
                        showButtonLogic = { [weak self] in
                            self?.present(viewControllerToPresent, animated: true, completion: nil)
                        }
                    
                        viewControllerToPresent.interactionAction = { [weak self] in
                            let newSize = PresentationSize(width: .fullscreen, height: .fullscreen)
                            try! self?.animator?.updateSize(presentationSize: newSize, duration: .medium)
                        }
                    case .updateCornerRadius:()
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe") as! DismissMeController
                        let alignment = PresentationAlignment(vertical: .top, horizontal: .center)
                        let uiConfig = PresentationUIConfiguration(cornerRadius: 10)
                        let marginGuards = UIEdgeInsets(top: 50, left: 16, bottom: 50, right: 16)
                        let presentation = CoverPresentation(directionShow: .top, directionDismiss: .top, uiConfiguration: uiConfig, size: PresentationSize(width: .fullscreen, height: .halfscreen), alignment: alignment, marginGuards: marginGuards)
                        let animator = Animator(presentation: presentation)
                        animator.prepare(presentedViewController: viewControllerToPresent)
                        self.animator = animator
                    
                        showButtonLogic = { [weak self] in
                            self?.present(viewControllerToPresent, animated: true, completion: nil)
                        }
                    
                        viewControllerToPresent.interactionAction = { [weak self] in
                            self?.animator?.updateCorners(radius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], duration: .medium)
                        }
                    case .updateMarginGuards:
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "PresentMe") as! DismissMeController
                        let alignment = PresentationAlignment(vertical: .top, horizontal: .center)
                        let uiConfig = PresentationUIConfiguration(cornerRadius: 10)
                        let marginGuards = UIEdgeInsets(top: 100, left: 32, bottom: 50, right: 32)
                        let presentation = CoverPresentation(directionShow: .top, directionDismiss: .top, uiConfiguration: uiConfig, size: PresentationSize(width: .fullscreen, height: .halfscreen), alignment: alignment, marginGuards: marginGuards)
                        let animator = Animator(presentation: presentation)
                        animator.prepare(presentedViewController: viewControllerToPresent)
                        self.animator = animator
                        
                        showButtonLogic = { [weak self] in
                            self?.present(viewControllerToPresent, animated: true, completion: nil)
                        }
                        
                        viewControllerToPresent.interactionAction = { [weak self] in
                            let newGuards = UIEdgeInsets(top: 70, left: 8, bottom: 0, right: 8)
                            try! self?.animator?.updateMarginGuards(marginGuards: newGuards, duration: .medium)
                        }
                }
        }
    }
}
