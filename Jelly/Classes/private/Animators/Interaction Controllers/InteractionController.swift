import UIKit

class InteractionController: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    private let configuration: InteractionConfiguration
    private let presentationType: Constants.PresentationType
    
    init(viewController: UIViewController, configuration: InteractionConfiguration, presentationType: Constants.PresentationType) {
        self.configuration = configuration
        self.viewController = viewController
        self.presentationType = presentationType
        super.init()
        prepareGestureRecognizer(in: viewController.view)
    }
        
    private func prepareGestureRecognizer(in view: UIView) {
        let dragDirection = presentationType == .show ? configuration.showDragDirection : configuration.dismissDragDirection
        switch configuration.dragMode {
            case .canvas:
                let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
                gesture.direction = try! dragDirection.panDirection()
                view.addGestureRecognizer(gesture)
            case .edge:
                let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
                gesture.edges = dragDirection
                view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = (abs(translation.x) / viewController.view.frame.width)
        progress = CGFloat(min(max(Float(progress), 0.0), 1.0))
        switch gestureRecognizer.state {
            case .began:
                interactionInProgress = true
                viewController.dismiss(animated: true, completion: nil)
            case .changed:
                shouldCompleteTransition = progress > configuration.completionThreshold
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
