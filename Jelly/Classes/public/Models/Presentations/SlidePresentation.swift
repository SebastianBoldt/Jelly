import Foundation

public struct SlidePresentation: Presentation,
                                   PresentationShowDirectionProvider,
                                   PresentationWidthProvider {
    
    public var presentationTiming: PresentationTimingProtocol
    public var presentationUIConfiguration: PresentationUIConfigurationProtocol
    public var showDirection: Constants.Direction
    public  var width: Constants.Size
    public  var spring: Constants.Spring
    
    public init(timing: PresentationTimingProtocol = PresentationTiming(),
                uiConfiguration: PresentationUIConfigurationProtocol = PresentationUIConfiguration(),
                direction: Constants.Direction = .bottom,
                width: Constants.Size = .fullscreen,
                spring: Constants.Spring = .none) {
        self.presentationUIConfiguration = uiConfiguration
        self.presentationTiming = timing
        self.width = width
        self.spring = spring
        self.showDirection = direction
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
