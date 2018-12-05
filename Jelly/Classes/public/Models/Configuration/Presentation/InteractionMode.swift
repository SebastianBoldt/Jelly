import Foundation

public struct InteractionMode: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let present = InteractionMode(rawValue: 1 << 0)
    public static let dismiss  = InteractionMode(rawValue: 1 << 1)
}
