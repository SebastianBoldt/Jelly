import Foundation

public protocol PresentationAnimatorProvider {
    var showAnimator: UIViewControllerAnimatedTransitioning { get }
    var dismissAnimator: UIViewControllerAnimatedTransitioning { get }
}

public protocol PresentationInteractiveAnimatorProvider {
    var interactiveShowAnimator: UIViewControllerInteractiveTransitioning? { get }
    var interactiveDismissAnimator: UIViewControllerInteractiveTransitioning? { get }
}
