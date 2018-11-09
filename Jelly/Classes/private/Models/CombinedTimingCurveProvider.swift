import UIKit

@objc(CombinedTimingCurveProvider) class CombinedTimingCurveProvider: NSObject, UITimingCurveProvider {
    var springTimingParameters: UISpringTimingParameters?
    var cubicTimingParameters: UICubicTimingParameters?
    var timingCurveType: UITimingCurveType {
        return .composed
    }
    
    init(springParameters: UISpringTimingParameters?, cubicParameters: UICubicTimingParameters?) {
        self.springTimingParameters = springParameters
        self.cubicTimingParameters = cubicParameters
    }
    
    override init() {
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return CombinedTimingCurveProvider(springParameters: self.springTimingParameters, cubicParameters: self.cubicTimingParameters)
    }
    
    public func encode(with aCoder: NSCoder) {
        return
    }
}
