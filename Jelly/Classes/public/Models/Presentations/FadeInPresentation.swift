import UIKit

public struct FadeInPresentation: PresentationAlignmentProvider, PresentationSizeProvider, PresentationTimingInformationProvider, PresentationUIConfigurationProvider {
    public var presentationAlignment: PresentationAlignmentProtocol
    public var presentationSize: PresentationSizeProtocol
    public var presentationTiming: PresentationTimingProtocol
    public var presentationUIConfiguration: PresentationUIConfigurationProtocol
    
    // TODO: Move to static default
    public init(alignment: PresentationAlignmentProtocol = PresenstationAlignment.centerAlignment,
                size: PresentationSizeProtocol = PresentationSize(marginGuards: .zero ,width: .fullscreen, height: .fullscreen),
                timing: PresentationTimingProtocol = PresentationTiming(duration: .normal, presentationCurve: .linear, dismissCurve: .linear ),
                ui: PresentationUIConfigurationProtocol = PresentationUIConfiguration(cornerRadius: 0.0, backgroundStyle: .dimmed(alpha: 0.5), isTapBackgroundToDismissEnabled: true, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])) {
        self.presentationAlignment = alignment
        self.presentationSize = size
        self.presentationTiming = timing
        self.presentationUIConfiguration = ui
    }
}
