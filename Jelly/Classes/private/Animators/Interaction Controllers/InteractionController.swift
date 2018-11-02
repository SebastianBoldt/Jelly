import UIKit

class InteractionController: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    private var shouldCompleteTransition = false
    
    private weak var presentedViewController: UIViewController!
    private weak var presentingViewController: UIViewController?
    private weak var presentationController: PresentationController?
    
    private let presentation: (InteractionConfigurationProvider & PresentationShowDirectionProvider)
    private let presentationType: PresentationType
    
    init(presentedViewController: UIViewController,
         presentingViewController: UIViewController?,
         presentationType: PresentationType,
         presentation: (InteractionConfigurationProvider & PresentationShowDirectionProvider),
         presentationController: PresentationController?) {
        self.presentedViewController = presentedViewController
        self.presentingViewController = presentingViewController
        self.presentation = presentation
        self.presentationType = presentationType
        self.presentationController = presentationController
        super.init()
        
        // BUG 1
        switch (presentationType, presentation.interactionConfiguration.dragMode) {
            case (.show, .canvas), (.show, .edge):
                guard let view = presentingViewController?.view else { break }
                prepareGestureRecognizer(in: view)
            case (.dismiss, .canvas):
                prepareGestureRecognizer(in: presentedViewController.view)
            case (.dismiss, .edge):
                prepareGestureRecognizer(in: presentationController!.dimmingView)
                prepareGestureRecognizer(in: presentationController!.blurView)
        }
    }
    
    public func setPresentationController(presentationController: PresentationController) {
        self.presentationController = presentationController
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        var dismissDirection = presentation.showDirection
        if let dismissProvider = presentation as? PresentationDismissDirectionProvider {
            dismissDirection = dismissProvider.dismissDirection
        }
        
        // BUG 2 
        let dragDirection = presentationType == .show ? presentation.showDirection : dismissDirection
        switch presentation.interactionConfiguration.dragMode {
            case .canvas:
                let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
                view.addGestureRecognizer(gesture)
            case .edge:
                let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
                if presentationType == .dismiss {
                    // THIS IS FUCKING FUGLY, clean this up .. pleaassseeee 😢
                    switch dragDirection {
                        case .bottom:
                            gesture.edges = .top
                        case .top:
                            gesture.edges = .bottom
                        case .left:
                            gesture.edges = .right
                        case .right:
                            gesture.edges = .left
                    }
                } else {
                    gesture.edges = dragDirection.rectEdges
                }
                view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let superView = gestureRecognizer.view?.superview else {
            return
        }
        
        let translation = gestureRecognizer.translation(in: superView)
        var progress: CGFloat = 0.0
        if presentationType == .show {
            switch presentation.showDirection {
                case .top:
                    let height = presentedViewController.view.frame.height
                    progress = (abs(translation.y) / height)
                case .bottom:
                    let height = presentedViewController.view.frame.height
                     progress = (abs(translation.y) / height)
                case .left:
                    let width = presentedViewController.view.frame.width
                     progress = (abs(translation.x) / width)
                case .right:
                    let width = presentedViewController.view.frame.width
                     progress = (abs(translation.x) / width)
            }
        } else if presentationType == .dismiss {
            var dismissDirection = presentation.showDirection
            if let dismissProvider = presentation as? PresentationDismissDirectionProvider {
                dismissDirection = dismissProvider.dismissDirection
            }
            
            switch dismissDirection {
                case .top:
                    let height = presentedViewController.view.frame.height
                    progress = (abs(translation.y) / height)
                case .bottom:
                    let height = presentedViewController.view.frame.height
                    progress = (abs(translation.y) / height)
                case .left:
                    let width = presentedViewController.view.frame.width
                    progress = (abs(translation.x) / width)
                case .right:
                    let width = presentedViewController.view.frame.width
                    progress = (abs(translation.x) / width)
            }
        }
        
        progress = CGFloat(min(max(Float(progress), 0.0), 1.0))
        updateTransition(with: progress, and: gestureRecognizer.state)
    }
    
    func updateTransition(with progress: CGFloat, and state: UIGestureRecognizer.State) {
        switch state {
            case .began:
                interactionInProgress = true
                if presentationType == .show {
                    presentingViewController?.present(presentedViewController, animated: true, completion: nil)
                } else {
                    presentedViewController.dismiss(animated: true, completion: nil)
                }
            case .changed:
                shouldCompleteTransition = progress > presentation.interactionConfiguration.completionThreshold
                update(progress)
            case .cancelled:
                interactionInProgress = false
                cancel()
            case .ended:
                interactionInProgress = false
                if shouldCompleteTransition {
                    finish()
                } else {
                    cancel()
                }
            default:
                break
        }
    }
}
