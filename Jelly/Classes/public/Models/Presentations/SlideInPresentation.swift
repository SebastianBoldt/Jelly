public struct SlideInPresentation: Presentation, AlignablePresentation, DynamicPresentation {
    
    // JellyPresentation Protocol conformance
    public   var dismissCurve: UIView.AnimationCurve = .linear
    public   var presentationCurve: UIView.AnimationCurve = .linear
    public   var cornerRadius: Double = 0.0
    public   var backgroundStyle: Constants.BackgroundStyle = .dimmed(alpha: 0.5)
    public   var spring: Constants.Spring
    public   var duration : Constants.Duration = .normal // Duration the ViewController needs to kick in
    public   var widthForViewController: Constants.Size = .halfscreen
    public   var heightForViewController: Constants.Size = .halfscreen
    public   var isTapBackgroundToDismissEnabled: Bool = true
    public   var marginGuards: UIEdgeInsets = .zero
    public   var corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    // Unique
    public   var directionShow: Constants.Direction = .left // Direction the ViewController slides in from
    public   var directionDismiss: Constants.Direction = .left // Direction the ViewController slides out to
    
    // Alginable
    public   var horizontalAlignment: Constants.HorizontalAlignment = .center
    public   var verticalAlignemt: Constants.VerticalAlignment = .center
    
    public init(dismissCurve: UIView.AnimationCurve = .linear,
                presentationCurve: UIView.AnimationCurve = .linear,
                cornerRadius: Double = 0.0,
                backgroundStyle: Constants.BackgroundStyle = .dimmed(alpha: 0.5),
                spring: Constants.Spring = .none,
                duration: Constants.Duration = .normal,
                directionShow: Constants.Direction = .top,
                directionDismiss: Constants.Direction = .top,
                widthForViewController: Constants.Size = .fullscreen,
                heightForViewController: Constants.Size = .fullscreen,
                horizontalAlignment: Constants.HorizontalAlignment = .center,
                verticalAlignment: Constants.VerticalAlignment = .center,
                marginGuards: UIEdgeInsets = .zero,
                corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]) {
        
        self.dismissCurve = dismissCurve
        self.presentationCurve = presentationCurve
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.spring = spring
        self.duration = duration
        self.directionShow = directionShow
        self.directionDismiss = directionDismiss
        self.widthForViewController = widthForViewController
        self.heightForViewController = heightForViewController
        self.verticalAlignemt = verticalAlignment
        self.horizontalAlignment = horizontalAlignment
        self.marginGuards = marginGuards
        self.corners = corners
    }
}
