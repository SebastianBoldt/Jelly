import UIKit

public struct CoverPresentation: Presentation,
    PresentationDismissDirectionProvider,
    PresentationShowDirectionProvider,
    PresentationMarginGuardsProvider,
    PresentationSizeProvider,
    PresentationAlignmentProvider,
    PresentationSpringProvider,
    InteractionConfigurationProvider {
    public var showDirection: Direction
    public var dismissDirection: Direction
    public var presentationTiming: PresentationTimingProtocol
    public var presentationUIConfiguration: PresentationUIConfigurationProtocol
    public var presentationSize: PresentationSizeProtocol
    public var presentationAlignment: PresentationAlignmentProtocol
    public var spring: Spring
    public var marginGuards: UIEdgeInsets
    public var interactionConfiguration: InteractionConfiguration?

    public init(directionShow: Direction,
                directionDismiss: Direction,
                uiConfiguration: PresentationUIConfigurationProtocol = PresentationUIConfiguration(),
                size: PresentationSizeProtocol = PresentationSize(),
                alignment: PresentationAlignmentProtocol = PresentationAlignment.centerAlignment,
                marginGuards: UIEdgeInsets = .zero,
                timing: PresentationTimingProtocol = PresentationTiming(),
                spring: Spring = .none,
                interactionConfiguration: InteractionConfiguration? = nil) {
        dismissDirection = directionDismiss
        showDirection = directionShow
        presentationTiming = timing
        presentationUIConfiguration = uiConfiguration
        presentationSize = size
        presentationAlignment = alignment
        self.spring = spring
        self.marginGuards = marginGuards
        presentationAlignment = alignment
        self.interactionConfiguration = interactionConfiguration
    }
}

extension CoverPresentation: PresentationAnimatorProvider {
    public var showAnimator: UIViewControllerAnimatedTransitioning {
        return CoverAnimator(presentationType: .show, presentation: self)
    }

    public var dismissAnimator: UIViewControllerAnimatedTransitioning {
        return CoverAnimator(presentationType: .dismiss, presentation: self)
    }
}
