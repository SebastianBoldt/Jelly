import Foundation

public enum VerticalAlignment {
    case top
    case bottom
    case center
    case custom(y: CGFloat)
}

public enum HorizontalAlignment {
    case left
    case right
    case center
    case custom(x: CGFloat)
}
