import Foundation

public struct ShiftInPresentation: PresentationShowDirectionProvider {
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
    
    public var presentationAlignment: PresentationAlignmentProtocol
    public var presentationSize: PresentationSizeProtocol
    public var presentationTiming: PresentationTimingProtocol
    public var presentationUIConfiguration: PresentationUIConfigurationProtocol
    
    // TODO: Move to static default
    public init(size: PresentationSizeProtocol = PresentationSize(marginGuards: .zero ,width: .fullscreen, height: .fullscreen),
                timing: PresentationTimingProtocol = PresentationTiming(duration: .normal, presentationCurve: .linear, dismissCurve: .linear ),
                ui: PresentationUIConfigurationProtocol = PresentationUIConfiguration(cornerRadius: 0.0, backgroundStyle: .dimmed(alpha: 0.5), isTapBackgroundToDismissEnabled: true, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])) {
        self.presentationAlignment = alignment
        self.presentationSize = size
        self.presentationTiming = timing
        self.presentationUIConfiguration = ui
    }
}
}
