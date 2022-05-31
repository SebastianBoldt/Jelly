import UIKit

public enum Spring {
    case custom(velocity: CGFloat, damping: CGFloat)
    case none
    case tight
    case medium
    case loose
}
