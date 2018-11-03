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
    
    public init(directionShow: Direction = .bottom,
                directionDismiss: Direction = .bottom,
                uiConfiguration: PresentationUIConfigurationProtocol = PresentationUIConfiguration(),
                size: PresentationSizeProtocol = PresentationSize(),
                alignment: PresentationAlignmentProtocol = PresentationAlignment.centerAlignment,
                marginGuards: UIEdgeInsets = .zero ,
                timing: PresentationTimingProtocol = PresentationTiming(),
                spring: Spring = .none,
                interactionConfiguration: InteractionConfiguration? = nil) {
        
        self.dismissDirection = directionDismiss
        self.showDirection = directionShow
        self.presentationTiming = timing
        self.presentationUIConfiguration = uiConfiguration
        self.presentationSize = size
        self.presentationAlignment = alignment
        self.spring = spring
        self.marginGuards = marginGuards
        self.presentationAlignment = alignment
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
