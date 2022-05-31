import Foundation

public protocol Presentation: PresentationTimingInformationProvider,
    PresentationUIConfigurationProvider,
    PresentationAnimatorProvider {
}
