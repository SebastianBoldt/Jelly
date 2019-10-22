import UIKit

extension UIViewControllerAnimatedTransitioning {
    func getPresentedViewControllerKeyForPresentationType(type: PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
        case .show:
            return .to
        case .dismiss:
            return .from
        }
    }

    func getUnderlyingViewControllerKeyForPresentationType(type: PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
        case .show:
            return .from
        case .dismiss:
            return .to
        }
    }
}
