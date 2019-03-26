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
    public var depthScale: CGFloat
    public var interactionConfiguration: InteractionConfiguration?
    
    public init(directionShow: Direction,
                directionDismiss: Direction,
                uiConfiguration: PresentationUIConfigurationProtocol = PresentationUIConfiguration(),
                size: PresentationSizeProtocol = PresentationSize(),
                alignment: PresentationAlignmentProtocol = PresentationAlignment.centerAlignment,
                marginGuards: UIEdgeInsets = .zero ,
                depthScale: CGFloat = 1.0,
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
        self.depthScale = depthScale
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
