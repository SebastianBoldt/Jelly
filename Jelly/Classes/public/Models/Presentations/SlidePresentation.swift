import UIKit

public struct SlidePresentation: Presentation,
    PresentationShowDirectionProvider,
    PresentationSingleSizeProvider,
    InteractionConfigurationProvider {
    public var presentationTiming: PresentationTimingProtocol
    public var presentationUIConfiguration: PresentationUIConfigurationProtocol
    public var showDirection: Direction
    public var size: Size
    public var spring: Spring
    public var interactionConfiguration: InteractionConfiguration?
    public var parallax: CGFloat

    public init(timing: PresentationTimingProtocol = PresentationTiming(),
                uiConfiguration: PresentationUIConfigurationProtocol = PresentationUIConfiguration(),
                direction: Direction = .bottom,
                size: Size = .fullscreen,
                spring: Spring = .none,
                parallax: CGFloat = 1.0,
                interactionConfiguration: InteractionConfiguration? = nil) {
        presentationUIConfiguration = uiConfiguration
        presentationTiming = timing
        self.size = size
        self.spring = spring
        showDirection = direction
        self.interactionConfiguration = interactionConfiguration
        self.parallax = parallax
    }
}

extension SlidePresentation: PresentationAnimatorProvider {
    public var showAnimator: UIViewControllerAnimatedTransitioning {
        return SlideAnimator(presentationType: .show, presentation: self)
    }

    public var dismissAnimator: UIViewControllerAnimatedTransitioning {
        return SlideAnimator(presentationType: .dismiss, presentation: self)
    }
}
