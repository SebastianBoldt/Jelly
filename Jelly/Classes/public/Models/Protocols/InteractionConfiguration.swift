import Foundation

public struct InteractionConfiguration {
    var completionThreshold: CGFloat     // How much of the transition need to be completed so it will finish
    var showDragDirection: UIRectEdge
    var dismissDragDirection: UIRectEdge
    var dragMode: Constants.DragMode
    
    public init(completionThreshold: CGFloat = 0.5, showDragDirection: UIRectEdge, dismissDragDirection: UIRectEdge, dragMode: Constants.DragMode) {
        self.completionThreshold = completionThreshold
        self.showDragDirection = showDragDirection
        self.dismissDragDirection = dismissDragDirection
        self.dragMode = dragMode
    }
}

protocol InteractionConfigurationProvider {
    var interactionConfiguration: InteractionConfiguration? { get }
}

extension UIRectEdge {
    public func panDirection() throws -> UISwipeGestureRecognizer.Direction {
        switch self {
            case .top:
                return .down
            case .left:
                return .left
            case .bottom:
                return .up
            case .right:
                return .right
            default:
                throw NSError(domain: "You can not use allEdges on a Canvas Interaction", code: 0, userInfo: nil)
        }
    }
}
