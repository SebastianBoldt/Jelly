import Foundation

public enum Direction {
    case top
    case bottom
    case left
    case right
    
    public func orientation() -> Orientation {
        switch self {
            case .left, .right :
                return .horizontal
            case .top, .bottom :
                return .vertical
        }
    }
}
