import Foundation

enum LiveUpdateError: Error {
    case notSupportedOnVerticalSlide
    case notSupportedOnHorizontalSlide
    case notSupportedOnSlide
}
