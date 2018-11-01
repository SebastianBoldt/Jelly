import Foundation

public struct ShiftInPresentation: Presentation,
                                   PresentationShowDirectionProvider,
                                   PresentationWidthProvider {
    
    public var presentationTiming: PresentationTimingProtocol
    public var presentationUIConfiguration: PresentationUIConfigurationProtocol
    public var showDirection: Constants.Direction
    public  var width: Constants.Size = .halfscreen
    public  var spring: Constants.Spring = .none
    
    public init(timing: PresentationTimingProtocol = PresentationTiming(duration: .medium, presentationCurve: .linear, dismissCurve: .linear),
                uiConfiguration: PresentationUIConfigurationProtocol = PresentationUIConfiguration(cornerRadius: 0.0, backgroundStyle: .dimmed(alpha:0.5), isTapBackgroundToDismissEnabled: true, corners:  [.topLeft, .topRight, .bottomLeft, .bottomRight]), direction: Constants.Direction = .bottom, width: Constants.Size = .fullscreen, spring: Constants.Spring = .none) {
        self.presentationUIConfiguration = uiConfiguration
        self.presentationTiming = timing
        self.width = width
        self.spring = spring
        self.showDirection = direction
    }
}

extension ShiftInPresentation: PresentationAnimatorProvider {
    public var showAnimator: UIViewControllerAnimatedTransitioning {
        return ShiftInPresentationAnimator(presentationType: .show, presentation: self)
    }
    
    public var dismissAnimator: UIViewControllerAnimatedTransitioning {
        return ShiftInPresentationAnimator(presentationType: .dismiss, presentation: self)
    }
}
