import Foundation
import UIKit

public protocol PresentationTimingInformationProvider {
    var presentationTiming: PresentationTimingProtocol { get set}
}

public protocol PresentationTimingProtocol {
    var duration: Constants.Duration { get set }
    var presentationCurve : UIView.AnimationCurve { get set }
    var dismissCurve : UIView.AnimationCurve { get set }
}

public struct PresentationTiming: PresentationTimingProtocol {
    public var duration: Constants.Duration
    public var presentationCurve: UIView.AnimationCurve
    public var dismissCurve: UIView.AnimationCurve
    
    public init(duration: Constants.Duration, presentationCurve: UIView.AnimationCurve, dismissCurve: UIView.AnimationCurve) {
        self.duration = duration
        self.presentationCurve = presentationCurve
        self.dismissCurve = dismissCurve
    }
}
