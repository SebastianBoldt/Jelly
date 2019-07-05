import UIKit

class InteractionController: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    
    private weak var presentedViewController: UIViewController!
    private weak var presentingViewController: UIViewController?
    private weak var presentationController: PresentationController?
    
    private let presentation: (InteractionConfigurationProvider & PresentationShowDirectionProvider)
    private let presentationType: PresentationType
    private let configuration: InteractionConfiguration
    
    init(configuration: InteractionConfiguration,
         presentedViewController: UIViewController,
         presentingViewController: UIViewController?,
         presentationType: PresentationType,
         presentation: (InteractionConfigurationProvider & PresentationShowDirectionProvider),
         presentationController: PresentationController?) {
        
        self.presentedViewController = presentedViewController
        self.presentingViewController = presentingViewController
        self.presentation = presentation
        self.presentationType = presentationType
        self.presentationController = presentationController
        self.configuration = configuration
        
        super.init()
        prepareGestureRecognizers()
    }
    
    public func setPresentationController(presentationController: PresentationController) {
        self.presentationController = presentationController
    }
    
    private func prepareGestureRecognizers() {
        switch (presentationType, configuration.dragMode) {
            case (.show, .canvas), (.show, .edge):
                if configuration.mode.contains(.present){
                    guard let view = presentingViewController?.view else { break }
                    addInteractionGestureRecognizer(to: view)
                }
            case (.dismiss, .canvas):
                if configuration.mode.contains(.dismiss){
                    addInteractionGestureRecognizer(to: presentedViewController.view)
                }
            case (.dismiss, .edge):
                if configuration.mode.contains(.dismiss){
                    prepareSpecialWorkAroundForDismissGestureRecognizers()
                }
        }
    }
    
    /*
         if orientation is vertical
            if height is >= than screen
                we should add it to the presntedViewController
            else if
                we add it to the dimming and blurView
         else if orientation is horizontal
            if width is >= than screen
                we should add it to the presntedViewController
            else if
                we add it to the dimming and blurView
     */
    //TODO: try to refactor this
    private func prepareSpecialWorkAroundForDismissGestureRecognizers() {
        var size: Size?
        if presentation.showDirection.orientation() == .vertical {
            if let sizeProvider = presentation as? PresentationSizeProvider {
                size = sizeProvider.presentationSize.height
            } else if let sizeProvider = presentation as? PresentationSingleSizeProvider {
                size = sizeProvider.size
            }
            
            guard let size = size else {
                return
            }
            
            switch size {
                case .fullscreen:
                    addInteractionGestureRecognizer(to: presentedViewController.view)
                case .custom(let height):
                    if height >= UIScreen.main.bounds.height {
                        addInteractionGestureRecognizer(to: presentedViewController.view)
                    } else {
                        addInteractionGestureRecognizer(to: presentationController!.dimmingView)
                        addInteractionGestureRecognizer(to: presentationController!.blurView)
                    }
                case .halfscreen:
                    addInteractionGestureRecognizer(to: presentationController!.dimmingView)
                    addInteractionGestureRecognizer(to: presentationController!.blurView)
                
            }
            
        } else if presentation.showDirection.orientation() == .horizontal {
            if let sizeProvider = presentation as? PresentationSizeProvider {
                size = sizeProvider.presentationSize.width
            } else if let singleSizeProvider = presentation as? PresentationSingleSizeProvider {
                size = singleSizeProvider.size
            }
            
            guard let size = size else {
                return
            }
            
            switch size {
                case .fullscreen:
                    addInteractionGestureRecognizer(to: presentedViewController.view)
                case .custom(let width):
                    if width >= UIScreen.main.bounds.width {
                        addInteractionGestureRecognizer(to: presentedViewController.view)
                    } else {
                        addInteractionGestureRecognizer(to: presentationController!.dimmingView)
                        addInteractionGestureRecognizer(to: presentationController!.blurView)
                    }
                case .halfscreen:
                    addInteractionGestureRecognizer(to: presentationController!.dimmingView)
                    addInteractionGestureRecognizer(to: presentationController!.blurView)
            }
        }
    }
        
    private func addInteractionGestureRecognizer(to view: UIView) {
        var dismissDirection = presentation.showDirection
        if let dismissProvider = presentation as? PresentationDismissDirectionProvider {
            dismissDirection = dismissProvider.dismissDirection
        }
        
        let dragDirection = presentationType == .show ? presentation.showDirection : dismissDirection
        switch configuration.dragMode {
            case .canvas:
                let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
                if #available(iOS 11.0, *) {
                    gesture.name = Constants.gestureRecognizerIdentifier
                }
                view.addGestureRecognizer(gesture)
            case .edge:
                let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
                gesture.edges = presentationType == .dismiss ? dragDirection.dismissRectEdges : dragDirection.showRectEdges
                if #available(iOS 11.0, *) {
                    gesture.name = Constants.gestureRecognizerIdentifier
                }
                view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let superView = gestureRecognizer.view?.superview else {
            return
        }
        
        var direction: Direction = presentation.showDirection
        if presentationType == .dismiss, let dismissProvider = presentation as? PresentationDismissDirectionProvider {
            direction = dismissProvider.dismissDirection
        }
        
        let translation = gestureRecognizer.translation(in: superView)
        var progress = getProgress(for: direction, translation: translation)
        progress = CGFloat(min(max(Float(progress), 0.0), 1.0))
        updateTransition(with: progress, and: gestureRecognizer.state)
    }
    
    private func getProgress(for direction: Direction, translation: CGPoint) -> CGFloat {
        let height = presentedViewController.view.frame.height
        let width = presentedViewController.view.frame.width
        switch (direction, presentationType) {
            case (.top, .show), (.bottom, .dismiss):
                return (abs(max(0,translation.y)) / height)
            case (.top, .dismiss), (.bottom, .show):
                return (abs(min(0,translation.y)) / height)
            case (.left, .show), (.right, .dismiss):
                return (abs(max(0,translation.x)) / width)
            case (.right, .show),(.left, .dismiss):
                return (abs(min(0,translation.x)) / width)
        }
    }
}

extension InteractionController {
    func updateTransition(with progress: CGFloat, and state: UIGestureRecognizer.State) {
        switch state {
            case .began:
                interactionInProgress = true
                performTransition(for: presentationType)
            case .changed:
                shouldCompleteTransition = progress > configuration.completionThreshold
                update(progress)
            case .cancelled:
                interactionInProgress = false
                cancel()
            case .ended:
                interactionInProgress = false
                if (!shouldCompleteTransition && progress == 0) {
                    presentationController?.cancelAnimationEffect()
                }
                shouldCompleteTransition ? finish() : cancel()
            default:
                break
        }
    }
    
    private func performTransition(for type: PresentationType) {
        switch presentationType {
            case .show:
                presentingViewController?.present(presentedViewController, animated: true, completion: nil)
            case .dismiss:
                presentedViewController.dismiss(animated: true, completion: nil)

        }
    }
}
