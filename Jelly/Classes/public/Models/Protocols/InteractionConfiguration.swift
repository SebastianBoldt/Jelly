import Foundation

public struct InteractionConfiguration {
    var completionThreshold: CGFloat     // How much of the transition need to be completed so it will finish
    var dragMode: DragMode
    
    public init(completionThreshold: CGFloat = 0.5, dragMode: DragMode) {
        self.completionThreshold = completionThreshold
        self.dragMode = dragMode
    }
}

protocol InteractionConfigurationProvider {
    var interactionConfiguration: InteractionConfiguration? { get }
}

extension Direction {
    public var panDirection: UISwipeGestureRecognizer.Direction {
        switch self {
            case .top:
                return .down
            case .left:
                return .left
            case .bottom:
                return .up
            case .right:
                return .right
        }
    }
    
    public var showRectEdges: UIRectEdge {
        switch self {
            case .top:
                return .top
            case .left:
                return .left
            case .bottom:
                return .bottom
            case .right:
                return .right
        }
    }
    
    public var dismissRectEdges: UIRectEdge {
        switch self {
            case .top:
                return .bottom
            case .bottom:
                return .top
            case .left:
                return .right
            case .right:
                return .left
        }
    }
}
