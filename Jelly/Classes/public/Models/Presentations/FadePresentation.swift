import UIKit

public struct FadePresentation: Presentation,
    PresentationAlignmentProvider,
    PresentationSizeProvider,
    PresentationMarginGuardsProvider {
    public var presentationAlignment: PresentationAlignmentProtocol
    public var presentationSize: PresentationSizeProtocol
    public var presentationUIConfiguration: PresentationUIConfigurationProtocol
    public var marginGuards: UIEdgeInsets
    public var presentationTiming: PresentationTimingProtocol

    public init(alignment: PresentationAlignmentProtocol = PresentationAlignment.centerAlignment,
                size: PresentationSizeProtocol = PresentationSize(width: .fullscreen, height: .fullscreen),
                marginGuards: UIEdgeInsets = .zero,
                timing: PresentationTimingProtocol = PresentationTiming(duration: .normal, presentationCurve: .linear, dismissCurve: .linear),
                ui: PresentationUIConfigurationProtocol = PresentationUIConfiguration(cornerRadius: 0.0, backgroundStyle: .dimmed(alpha: 0.5), isTapBackgroundToDismissEnabled: true, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])) {
        presentationAlignment = alignment
        presentationSize = size
        presentationTiming = timing
        presentationUIConfiguration = ui
        self.marginGuards = marginGuards
    }
}

extension FadePresentation: PresentationAnimatorProvider {
    public var showAnimator: UIViewControllerAnimatedTransitioning {
        return FadeAnimator(presentationType: .show, presentation: self)
    }

    public var dismissAnimator: UIViewControllerAnimatedTransitioning {
        return FadeAnimator(presentationType: .dismiss, presentation: self)
    }
}
