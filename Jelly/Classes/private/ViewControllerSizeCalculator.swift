import Foundation

protocol ViewControllerSizeCalulatorProtocol {
    func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize, presentation: Presentation) -> CGSize
    func getFrameOfPresentedViewInContainerView(containerView: UIView, presentation: Presentation, presentedViewController: UIViewController) -> CGRect
    func getFrameForSlidePresentation(presentation: SlidePresentation, containerView: UIView) -> CGRect
    func getFrameForFadeOrCoverPresentation(presentation: Presentation, containerView: UIView, presentedViewController: UIViewController) -> CGRect
    func getSizeValue(fromPresentation presentation: SlidePresentation, containerView: UIView) -> CGFloat
    func applymarginGuards(toFrame frame: inout CGRect, marginGuards: UIEdgeInsets, container: CGSize)
    func limit(frame: inout CGRect, withSize size: CGSize)
    func align(frame: inout CGRect, withPresentation presentation: Presentation, containerView: UIView)
}

class ViewControllerSizeCalculator: ViewControllerSizeCalulatorProtocol {    
    func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize, presentation: Presentation) -> CGSize {
        var width : CGFloat = 0.0
        var height : CGFloat = 0.0
        guard let nonFullScreenPresentation = presentation as? PresentationSizeProvider else {
            return parentSize
        }
        
        switch nonFullScreenPresentation.presentationSize.width {
            case .fullscreen:
                width = parentSize.width
            case .halfscreen:
                width = parentSize.width / 2
            case .custom(let value):
                width = value
        }
        
        switch nonFullScreenPresentation.presentationSize.height {
            case .fullscreen:
                height = parentSize.height
            case .halfscreen:
                height = parentSize.height / 2
            case .custom(let value):
                height = value
        }
        
        return CGSize(width: width, height: height)
    }
    
    func getFrameOfPresentedViewInContainerView(containerView: UIView, presentation: Presentation, presentedViewController: UIViewController) -> CGRect {
        if let slideIn = presentation as? SlidePresentation {
            return getFrameForSlidePresentation(presentation: slideIn, containerView: containerView)
        } else {
            return getFrameForFadeOrCoverPresentation(presentation: presentation, containerView: containerView, presentedViewController: presentedViewController)
        }
    }
    
    func getFrameForFadeOrCoverPresentation(presentation: Presentation, containerView: UIView, presentedViewController: UIViewController) -> CGRect {
        guard let sizeProvider = presentation as? PresentationSizeProvider else {
            return CGRect(x: 0,y: 0,width: containerView.bounds.size.width, height: containerView.bounds.size.height)
        }
        
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size, presentation: presentation)
        limit(frame: &frame, withSize: frame.size)
        let marginGuards =  (sizeProvider as? PresentationMarginGuardsProvider)?.marginGuards ?? .zero
        align(frame: &frame, withPresentation: presentation, containerView: containerView)
        applymarginGuards(toFrame: &frame, marginGuards: marginGuards, container: containerView.bounds.size)
        return frame
    }
    
    func getFrameForSlidePresentation(presentation: SlidePresentation, containerView: UIView) -> CGRect {
        var slideInFrame : CGRect = .zero
        let size = getSizeValue(fromPresentation: presentation, containerView: containerView)
        switch presentation.showDirection {
            case .left:
                slideInFrame = CGRect(x: 0, y: 0, width: size, height: containerView.bounds.size.height)
            case .right:
                slideInFrame = CGRect(x: containerView.bounds.size.width - size, y: 0, width: size, height: containerView.bounds.size.height)
            case .top:
                slideInFrame =  CGRect(x: 0, y: 0, width: containerView.bounds.size.width, height: size)
            case .bottom:
                slideInFrame = CGRect(x: 0, y: containerView.bounds.size.height - size , width: containerView.bounds.size.width, height: size)
        }
        limit(frame: &slideInFrame, withSize: containerView.bounds.size)
        return slideInFrame
    }
    
    func getSizeValue(fromPresentation presentation: SlidePresentation, containerView: UIView) -> CGFloat{
        switch  presentation.size {
            case .custom(let value):
                return value
            case .halfscreen:
                if presentation.showDirection.orientation() == .horizontal {
                    return (containerView.frame.size.width) / 2
                } else {
                    return (containerView.frame.size.height) / 2
                }
            case .fullscreen:
                if presentation.showDirection.orientation() == .horizontal {
                    return (containerView.frame.size.width)
                } else {
                    return (containerView.frame.size.height)
                }
        }
    }
    
    func applymarginGuards(toFrame frame: inout CGRect, marginGuards: UIEdgeInsets, container: CGSize){
        // Apply Width
        if frame.width > container.width - (marginGuards.left + marginGuards.right) {
            let width = frame.width - (marginGuards.left + marginGuards.right)
            frame.size = CGSize(width: width, height: frame.height)
        }
        
        if frame.origin.x < marginGuards.left {
            frame.origin.x = marginGuards.left
        }
        
        if (frame.origin.x + frame.size.width) >= container.width {
            frame.origin.x = frame.origin.x - marginGuards.right
        }
        
        // Apply Height
        if frame.height > container.height - (marginGuards.top + marginGuards.bottom) {
            let height = frame.height - (marginGuards.top + marginGuards.bottom)
            frame.size = CGSize(width: frame.width, height: height)
        }
        
        if frame.origin.y < marginGuards.top {
            frame.origin.y = marginGuards.top
        }
        
        if (frame.origin.y + frame.size.height) >= container.height {
            frame.origin.y = frame.origin.y - marginGuards.bottom
        }
    }
    
    /// If the Frame is to big, limit resizes it to the size passed in
    ///
    /// - Parameters:
    ///   - frame: frame to limit
    ///   - size: size to apply
    func limit(frame: inout CGRect, withSize size: CGSize) {
        if (frame.size.height > size.height) {
            frame.origin.y = 0
            frame.size.height = size.height
        }
        
        if (frame.size.width > size.width) {
            frame.origin.x = 0
            frame.size.width = size.width
        }
    }
    
    /// Align alignes the Frame using the alignment options specified inside the presentation object
    ///
    /// - Parameters:
    ///   - frame: frame to align
    ///   - presentation: presentation which will be used to provide the alignment options
    func align(frame: inout CGRect, withPresentation presentation: Presentation, containerView: UIView) {
        if let alignablePresentation = presentation as? PresentationAlignmentProvider {
            // Prepare Horizontal Alignment
            switch alignablePresentation.presentationAlignment.horizontalAlignment {
                case .center:
                    frame.origin.x = (containerView.frame.size.width/2)-(frame.size.width/2)
                case .left:
                    frame.origin.x = 0
                case .right:
                    frame.origin.x = (containerView.frame.size.width) - frame.size.width
                case .custom(let x):
                    frame.origin.x = x
            }
            
            // Prepare Vertical Alignment
            switch alignablePresentation.presentationAlignment.verticalAlignemt {
                case .center:
                    frame.origin.y = (containerView.frame.size.height/2)-(frame.size.height/2)
                case .top:
                    frame.origin.y = 0
                case .bottom:
                    frame.origin.y = (containerView.frame.size.height) - frame.size.height
                case .custom(let y):
                    frame.origin.y = y
            }
        } else {
            frame.origin.x = (containerView.frame.size.width/2)-(frame.size.width/2)
            frame.origin.y = (containerView.frame.size.height/2)-(frame.size.height/2)
        }
    }
}
