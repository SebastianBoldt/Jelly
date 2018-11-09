import Foundation

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
    
    public init(timing: PresentationTimingProtocol = PresentationTiming(),
                uiConfiguration: PresentationUIConfigurationProtocol = PresentationUIConfiguration(),
                direction: Direction = .bottom,
                size: Size = .fullscreen,
                spring: Spring = .none,
                interactionConfiguration: InteractionConfiguration? = nil) {
        self.presentationUIConfiguration = uiConfiguration
        self.presentationTiming = timing
        self.size = size
        self.spring = spring
        self.showDirection = direction
        self.interactionConfiguration = interactionConfiguration
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
