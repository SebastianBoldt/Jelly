import Foundation


public struct InteractionConfiguration {
    var completionThreshold: CGFloat
    var dragMode: DragMode
    weak var presentingViewController: UIViewController!
    
    public init(presentingViewController: UIViewController, completionThreshold: CGFloat = 0.5, dragMode: DragMode) {
        self.completionThreshold = completionThreshold
        self.dragMode = dragMode
        self.presentingViewController = presentingViewController
    }
}
