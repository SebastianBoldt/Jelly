public struct SlideInPresentation: Presentation,
                                   PresentationDismissDirectionProvider,
                                   PresentationShowDirectionProvider,
                                   PresentationMarginGuardsProvider,
                                   PresentationSizeProvider,
                                   PresentationAlignmentProvider,
                                   PresentationSpringProvider {
    
    public var showDirection: Constants.Direction
    public var dismissDirection: Constants.Direction
    public var presentationTiming: PresentationTimingProtocol
    public var presentationUIConfiguration: PresentationUIConfigurationProtocol
    public var presentationSize: PresentationSizeProtocol
    public var presentationAlignment: PresentationAlignmentProtocol
    public var spring: Constants.Spring
    public var marginGuards: UIEdgeInsets

    public init(directionShow: Constants.Direction = .left,
                directionDismiss: Constants.Direction = .left,
                uiConfiguration: PresentationUIConfigurationProtocol = PresentationUIConfiguration(),
                size: PresentationSizeProtocol = PresentationSize(width: .halfscreen, height: .halfscreen),
                alignment: PresentationAlignmentProtocol = PresentationAlignment.centerAlignment,
                marginGuards: UIEdgeInsets = .zero ,
                timing: PresentationTimingProtocol = PresentationTiming(duration: .normal, presentationCurve: .linear, dismissCurve: .linear),
                spring: Constants.Spring = .none) {
        
        self.dismissDirection = directionDismiss
        self.showDirection = directionShow
        self.presentationTiming = timing
        self.presentationUIConfiguration = uiConfiguration
        self.presentationSize = size
        self.presentationAlignment = alignment
        self.spring = spring
        self.marginGuards = marginGuards
        self.presentationAlignment = alignment
    }
}

extension SlideInPresentation: PresentationAnimatorProvider {
    public var showAnimator: UIViewControllerAnimatedTransitioning {
        return SlideInPresentationAnimator(presentationType: .show, presentation: self)
    }
    
    public var dismissAnimator: UIViewControllerAnimatedTransitioning {
        return SlideInPresentationAnimator(presentationType: .dismiss, presentation: self)
    }
}
