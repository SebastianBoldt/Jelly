import Foundation

public struct ShiftInPresentation: Presentation {    
    public  var dismissCurve: UIView.AnimationCurve = .linear
    public  var presentationCurve: UIView.AnimationCurve = .linear
    public  var cornerRadius: Double = 0.0
    public  var backgroundStyle: Constants.BackgroundStyle = .dimmed(alpha:0.5)
    public  var spring: Constants.Spring = .none
    public  var duration : Constants.Duration = .medium // Duration the ViewController needs to kick in
    public  var isTapBackgroundToDismissEnabled: Bool = true
    public  var direction : Constants.Direction = .bottom
    public  var size: Constants.Size = .halfscreen
    public  var corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    
    public init(dismissCurve: UIView.AnimationCurve = .linear,
                presentationCurve: UIView.AnimationCurve = .linear,
                cornerRadius: Double = 0.0,
                backgroundStyle: Constants.BackgroundStyle = .dimmed(alpha: 0.5),
                spring: Constants.Spring = .none,
                duration: Constants.Duration = .normal,
                direction: Constants.Direction = .bottom,
                size: Constants.Size = .halfscreen,
                corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]) {
        
        self.dismissCurve = dismissCurve
        self.presentationCurve = presentationCurve
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.spring = spring
        self.duration = duration
        self.direction = direction
        self.size = size
        self.corners = corners
    }
}
