//
//  PresentationController.swift
//  Created by Sebastian Boldt on 17.11.16.

import UIKit

/// A PresentationController tells UIKit what exactly to do with the View that should be presented
/// It also reacts to transtion state changes etc.
/// We  use this controller to setup dimmingView, blurView, positioning the presented ViewController etc.

final class PresentationController : UIPresentationController {
    fileprivate var presentation: Presentation
    fileprivate var dimmingView: UIView = UIView()
    fileprivate var blurView: UIVisualEffectView = UIVisualEffectView()
    
    init(presentedViewController: UIViewController, presentingViewController: UIViewController?, presentation: Presentation) {
        self.presentation = presentation
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
        
        presentedViewController.view.layer.masksToBounds = true
        presentedViewController.view.roundCorners(corners: self.presentation.corners, radius: presentation.cornerRadius)
    }
    
    override func presentationTransitionWillBegin() {
        switch self.presentation.backgroundStyle {
            case .blurred(let effectStyle):
                self.setupBlurView()
                animateBlurView(effectStyle: effectStyle)
            case .dimmed(let alpha):
                self.setupDimmingView(withAlpha: alpha)
                animateDimmingView()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
            self.blurView.effect = nil
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.roundCorners(corners: self.presentation.corners, radius: self.presentation.cornerRadius)
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        
        guard let nonFullScreenPresentation = self.presentation as? DynamicPresentation else {
            return parentSize
        }
        
        var width : CGFloat = 0.0
        switch nonFullScreenPresentation.widthForViewController {
            case .fullscreen:
                width = parentSize.width
            case .halfscreen:
                width = parentSize.width / 2
            case .custom(let value):
                width = value
        }
        
        var height : CGFloat = 0.0
        switch nonFullScreenPresentation.heightForViewController {
            case .fullscreen:
                height = parentSize.height
            case .halfscreen:
                height = parentSize.height / 2
            case .custom(let value):
                height = value
        }
        
        return CGSize(width: width, height: height)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        if let shiftIn = self.presentation as? ShiftInPresentation {
            return self.getFrameForShiftInPresentation(shiftIn: shiftIn)
        }
        
        guard let dynamicPresentation = self.presentation as? DynamicPresentation else {
            return CGRect(x:0,y:0,width: containerView!.bounds.size.width, height: containerView!.bounds.size.height)
        }
        
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        limit(frame: &frame, withSize: frame.size)
        align(frame: &frame, withPresentation: self.presentation)
        applymarginGuards(toFrame: &frame, marginGuards: dynamicPresentation.marginGuards, container: containerView!.bounds.size)
        
        return frame
    }
    
    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        if self.presentation.isTapBackgroundToDismissEnabled {
            presentingViewController.dismiss(animated: true)
        }
    }
}

extension PresentationController {
    private func animateBlurView(effectStyle: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: effectStyle)
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            self.blurView.effect = effect
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.blurView.effect = effect
        })
    }
    
    private func animateDimmingView() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    private func getFrameForShiftInPresentation(shiftIn: ShiftInPresentation) -> CGRect {
        var shiftFrame : CGRect = .zero
        let size = getSizeValue(fromPresentation: shiftIn)
        switch shiftIn.direction {
            case .left:
                shiftFrame = CGRect(x: 0, y: 0, width: size, height: containerView!.bounds.size.height)
            case .right:
                shiftFrame = CGRect(x: containerView!.bounds.size.width - size, y: 0, width: size, height: containerView!.bounds.size.height)
            case .top:
                shiftFrame =  CGRect(x: 0, y: 0, width: containerView!.bounds.size.width, height: size)
            case .bottom:
                shiftFrame = CGRect(x: 0, y: containerView!.bounds.size.height - size , width: containerView!.bounds.size.width, height: size)
        }
        limit(frame: &shiftFrame, withSize: containerView!.bounds.size)
        return shiftFrame
    }
    
    private func getSizeValue(fromPresentation presentation: ShiftInPresentation) -> CGFloat{
        switch  presentation.size {
            case .custom(let value):
                return value
            case .halfscreen:
                if presentation.direction.orientation() == .horizontal {
                    return (self.containerView?.frame.size.width)! / 2
                } else {
                    return (self.containerView?.frame.size.height)! / 2
                }
            case .fullscreen:
                if presentation.direction.orientation() == .horizontal {
                    return (self.containerView?.frame.size.width)!
                } else {
                    return (self.containerView?.frame.size.height)!
                }
            }
    }
    
    private func applymarginGuards(toFrame frame: inout CGRect, marginGuards: UIEdgeInsets, container: CGSize){
        // Apply horizontal marginGuards
        if (frame.origin.x <= 0) {
            frame.origin.x = marginGuards.left
        }
        
        if((frame.origin.x + frame.width) >= (container.width - marginGuards.right)) {
            let delta =  (frame.origin.x + frame.width) - container.width
            frame.size = CGSize(width: frame.width - delta - marginGuards.right , height: frame.height)
        }
        
        // Apply vertical marginGuards
        if (frame.origin.y <= marginGuards.top) {
            frame.origin.y = marginGuards.top
        }
        
        if((frame.origin.y + frame.height) >= (container.height - marginGuards.bottom)) {
            let delta =  (frame.origin.y + frame.height) - container.height
            frame.size = CGSize(width: frame.width , height: frame.height - delta - marginGuards.bottom)
        }
    }
    
    /// If the Frame is to big, limit resizes it to the size passed in
    ///
    /// - Parameters:
    ///   - frame: frame to limit
    ///   - size: size to apply
    private func limit(frame: inout CGRect, withSize size: CGSize) {
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
    private func align(frame: inout CGRect, withPresentation presentation: Presentation) {
        
        if let alignablePresentation = presentation as? AlignablePresentation {
            
            // Prepare Horizontal Alignment
            switch alignablePresentation.horizontalAlignment {
                case .center:
                    frame.origin.x = (containerView!.frame.size.width/2)-(frame.size.width/2)
                case .left:
                    frame.origin.x = 0
                case .right:
                    frame.origin.x = (containerView?.frame.size.width)! - frame.size.width
                case .custom(let x):
                    frame.origin.x = x
                }
            
            // Prepare Vertical Alignment
            switch alignablePresentation.verticalAlignemt {
                case .center:
                    frame.origin.y = (containerView!.frame.size.height/2)-(frame.size.height/2)
                case .top:
                    frame.origin.y = 0
                case .bottom:
                    frame.origin.y = (containerView?.frame.size.height)! - frame.size.height
                case .custom(let y):
                    frame.origin.y = y
                }
        } else {
            frame.origin.x = (containerView!.frame.size.width/2)-(frame.size.width/2)
            frame.origin.y = (containerView!.frame.size.height/2)-(frame.size.height/2)
        }
    }
}
extension PresentationController {
    private func setupBlurView () {
        guard let containerView = containerView else {
            return
        }
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        blurView.addGestureRecognizer(recognizer)
        containerView.insertSubview(blurView, at: 0)
    
        if #available(iOS 9.0, *) {
            blurView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
            blurView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            blurView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            blurView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|[blurView]|",
                                               options: [], metrics: nil, views: ["blurView": blurView]))
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|[blurView]|",
                                               options: [], metrics: nil, views: ["blurView": blurView]))
        }
    }
    
    private func setupDimmingView(withAlpha alpha: CGFloat = 0.5) {
        guard let containerView = containerView else {
            return
        }
        
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alpha = 0.0
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: alpha)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
        containerView.insertSubview(dimmingView, at: 0)
        
        if #available(iOS 9.0, *) {
            dimmingView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
            dimmingView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                               options: [], metrics: nil, views: ["dimmingView": dimmingView]))
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                               options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        }
    }
}
