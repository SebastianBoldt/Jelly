import UIKit

public protocol PresentationAnimatorProvider {
    var showAnimator: UIViewControllerAnimatedTransitioning { get }
    var dismissAnimator: UIViewControllerAnimatedTransitioning { get }
}
