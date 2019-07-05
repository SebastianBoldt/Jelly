import UIKit

protocol PresentationControllerProtocol {
    func updatePresentation(presentation: Presentation, duration: Duration)
    var dimmingView: UIView { get }
    var blurView: UIVisualEffectView { get }
}

/// A PresentationController tells UIKit what exactly to do with the View that should be presented
/// It also reacts to transtion state changes etc.
/// We  use this controller to setup dimmingView, blurView, positioning and resize the the presented ViewController etc.
final class PresentationController: UIPresentationController, PresentationControllerProtocol {
    private var presentation: Presentation
    private let sizeCalulator: ViewControllerSizeCalculator = ViewControllerSizeCalculator()
    
    // Blur and Dimming View needs to be accessible because the Interactor attaches Gesture-Recognizer to them when
    // using an edge pan gesture. This must be done, because it wont work other wise with non full screen viewController transitions
    private(set) var dimmingView: UIView = UIView()
    private(set) var blurView: UIVisualEffectView = UIVisualEffectView()
    
    init(presentedViewController: UIViewController, presentingViewController: UIViewController?, presentation: Presentation) {
        self.presentation = presentation
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.view.layer.masksToBounds = true
        let corners = presentation.presentationUIConfiguration.corners
        let radius = presentation.presentationUIConfiguration.cornerRadius
        presentedViewController.view.roundCorners(corners, radius: radius)
    }

    func updatePresentation(presentation: Presentation, duration: Duration) {
        self.presentation = presentation
        containerView?.setNeedsLayout()
        UIView.animate(withDuration: duration.timeInterval) {
            self.containerView?.layoutIfNeeded()
        }
    }
    
    override func presentationTransitionWillBegin() {
        let backgroundStyle = presentation.presentationUIConfiguration.backgroundStyle
        switch backgroundStyle {
            case .blurred(let effectStyle):
                self.setupBlurView()
                animateBlurView(effectStyle: effectStyle)
            case .dimmed(let alpha):
                self.setupDimmingView(withAlpha: alpha)
                animateDimmingView(alpha: alpha)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let backgroundStyle = presentation.presentationUIConfiguration.backgroundStyle
        switch backgroundStyle {
            case .blurred:
                animateBlurView(effectStyle: nil)
            case .dimmed:
                animateDimmingView(alpha: 0.0)
        }
    }
    
    override func containerViewWillLayoutSubviews() {        
        presentedView?.frame = frameOfPresentedViewInContainerView
        let corners = presentation.presentationUIConfiguration.corners
        let radius = presentation.presentationUIConfiguration.cornerRadius
        presentedView?.roundCorners(corners, radius: radius)
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        return sizeCalulator.size(forChildContentContainer: container,
                                  withParentContainerSize: parentSize,
                                  presentation: presentation)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return sizeCalulator.getFrameOfPresentedViewInContainerView(containerView: containerView!, presentation: presentation, presentedViewController: presentedViewController)
    }
    
    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        if presentation.presentationUIConfiguration.isTapBackgroundToDismissEnabled {
            presentingViewController.dismiss(animated: true)
        }
    }
}

extension PresentationController {
    private func animateBlurView(effectStyle: UIBlurEffect.Style?) {
        let effect: UIBlurEffect? = (effectStyle != nil) ? UIBlurEffect(style: effectStyle!) : nil
        guard let coordinator = presentedViewController.transitionCoordinator else {
            blurView.effect = effect
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.blurView.effect = effect
        })
    }
    
    private func animateDimmingView(alpha: CGFloat) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = alpha
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = alpha
        })
    }
    
    public func cancelAnimationEffect() {
        let backgroundStyle = presentation.presentationUIConfiguration.backgroundStyle
        switch backgroundStyle {
        case .blurred(let style):
            blurView.effect = UIBlurEffect(style: style)
        case .dimmed(let alpha):
            dimmingView.alpha = alpha
        }
    }
}
extension PresentationController {
    private func setupBlurView () {
        guard let containerView = containerView else {
            return
        }
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        recognizer.delegate = self
        blurView.addGestureRecognizer(recognizer)
        containerView.insertSubview(blurView, at: 0)

        blurView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

    }
    
    private func setupDimmingView(withAlpha alpha: CGFloat = 0.5) {
        guard let containerView = containerView else {
            return
        }
        
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alpha = 0.0
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: alpha)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
        containerView.insertSubview(dimmingView, at: 0)
        
        dimmingView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        dimmingView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

    }
}

extension PresentationController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
