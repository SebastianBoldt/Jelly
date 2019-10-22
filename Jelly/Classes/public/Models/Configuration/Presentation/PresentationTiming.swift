import UIKit

public struct PresentationTiming: PresentationTimingProtocol {
    public var duration: Duration
    public var presentationCurve: UIView.AnimationCurve
    public var dismissCurve: UIView.AnimationCurve
    
    public init(duration: Duration = .medium,
                presentationCurve: UIView.AnimationCurve = .linear,
                dismissCurve: UIView.AnimationCurve = .linear) {
        self.duration = duration
        self.presentationCurve = presentationCurve
        self.dismissCurve = dismissCurve
    }
}
