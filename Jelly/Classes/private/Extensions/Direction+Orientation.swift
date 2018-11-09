import Foundation

extension Direction {
    public func orientation() -> Orientation {
        switch self {
            case .left, .right :
                return .horizontal
            case .top, .bottom :
                return .vertical
            }
    }
}
