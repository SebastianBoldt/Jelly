import UIKit

extension UIView {
    public func roundCorners(corners: UIRectCorner = .allCorners, radius: Double = 0.0) {
        self.layer.masksToBounds = true
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width:radius, height:radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }
}
