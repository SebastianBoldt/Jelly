import UIKit

extension Direction {
    var panDirection: UISwipeGestureRecognizer.Direction {
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

    var showRectEdges: UIRectEdge {
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

    var dismissRectEdges: UIRectEdge {
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
