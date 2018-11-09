import Foundation

extension Spring {
    var damping: CGFloat {
        switch self {
            case .none:
                return 1.0
            case .tight:
                return 0.7
            case .medium:
                return 0.5
            case .loose:
                return 0.2
        }
    }
    
    var velocity: CGFloat {
        switch self {
            case .none:
                return 0
            case .tight:
                return 1
            case .medium:
                return 3
            case .loose:
                return 4
        }
    }
}
