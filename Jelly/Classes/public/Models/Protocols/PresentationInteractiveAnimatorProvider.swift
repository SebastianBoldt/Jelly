import UIKit

public protocol PresentationInteractiveAnimatorProvider {
    var interactiveShowAnimator: UIViewControllerInteractiveTransitioning? { get }
    var interactiveDismissAnimator: UIViewControllerInteractiveTransitioning? { get }
}
