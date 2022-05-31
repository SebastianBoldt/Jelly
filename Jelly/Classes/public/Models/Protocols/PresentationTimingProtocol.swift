import UIKit

public protocol PresentationTimingProtocol {
    var duration: Duration { get set }
    var presentationCurve: UIView.AnimationCurve { get set }
    var dismissCurve: UIView.AnimationCurve { get set }
}
