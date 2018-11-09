//
//  TouchVisualizer.swift
//  TouchVisualizer
//

import UIKit

final public class Visualizer:NSObject {
    
    // MARK: - Public Variables
    static public let sharedInstance = Visualizer()
    fileprivate var enabled = false
    fileprivate var config: Configuration!
    fileprivate var touchViews = [TouchView]()
    fileprivate var previousLog = ""
    
    // MARK: - Object life cycle
    private override init() {
      super.init()
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(Visualizer.orientationDidChangeNotification(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        NotificationCenter
            .default
            .addObserver(self, selector: #selector(Visualizer.applicationDidBecomeActiveNotification(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        UIDevice
            .current
            .beginGeneratingDeviceOrientationNotifications()
        
        warnIfSimulator()
    }
    
    deinit {
        NotificationCenter
            .default
            .removeObserver(self)
    }
    
    // MARK: - Helper Functions
    @objc internal func applicationDidBecomeActiveNotification(_ notification: Notification) {
        UIApplication.shared.keyWindow?.swizzle()
    }
    
    @objc internal func orientationDidChangeNotification(_ notification: Notification) {
        let instance = Visualizer.sharedInstance
        for touch in instance.touchViews {
            touch.removeFromSuperview()
        }
    }
    
    public func removeAllTouchViews() {
        for view in self.touchViews {
            view.removeFromSuperview()
        }
    }
}

extension Visualizer {
    public class func isEnabled() -> Bool {
        return sharedInstance.enabled
    }
    
    // MARK: - Start and Stop functions
    
    public class func start(_ config: Configuration = Configuration()) {
		
		if config.showsLog {
			print("Visualizer start...")
		}
        let instance = sharedInstance
        instance.enabled = true
        instance.config = config
        
        if let window = UIApplication.shared.keyWindow {
            for subview in window.subviews {
                if let subview = subview as? TouchView {
                    subview.removeFromSuperview()
                }
            }
        }
		if config.showsLog {
			print("started !")
		}
    }
    
    public class func stop() {
        let instance = sharedInstance
        instance.enabled = false
        
        for touch in instance.touchViews {
            touch.removeFromSuperview()
        }
    }
    
    public class func getTouches() -> [UITouch] {
        let instance = sharedInstance
        var touches: [UITouch] = []
        for view in instance.touchViews {
            guard let touch = view.touch else { continue }
            touches.append(touch)
        }
        return touches
    }
    
    // MARK: - Dequeue and locating TouchViews and handling events
    private func dequeueTouchView() -> TouchView {
        var touchView: TouchView?
        for view in touchViews {
            if view.superview == nil {
                touchView = view
                break
            }
        }
        
        if touchView == nil {
            touchView = TouchView()
            touchViews.append(touchView!)
        }
        
        return touchView!
    }
    
    private func findTouchView(_ touch: UITouch) -> TouchView? {
        for view in touchViews {
            if touch == view.touch {
                return view
            }
        }
        
        return nil
    }
    
    public func handleEvent(_ event: UIEvent) {
        if event.type != .touches {
            return
        }
        
        if !Visualizer.sharedInstance.enabled {
            return
        }

        var topWindow = UIApplication.shared.keyWindow!
        for window in UIApplication.shared.windows {
            if window.isHidden == false && window.windowLevel > topWindow.windowLevel {
                topWindow = window
            }
        }
        
        for touch in event.allTouches! {
            let phase = touch.phase
            switch phase {
            case .began:
                let view = dequeueTouchView()
                view.config = Visualizer.sharedInstance.config
                view.touch = touch
                view.beginTouch()
                view.center = touch.location(in: topWindow)
                topWindow.addSubview(view)
                log(touch)
            case .moved:
                if let view = findTouchView(touch) {
                    view.center = touch.location(in: topWindow)
                }
                
                log(touch)
            case .stationary:
                log(touch)
            case .ended, .cancelled:
                if let view = findTouchView(touch) {
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: .allowUserInteraction, animations: { () -> Void  in
                        view.alpha = 0.0
                        view.endTouch()
                    }, completion: { [unowned self] (finished) -> Void in
                        view.removeFromSuperview()
                        self.log(touch)
                    })
                }
                
                log(touch)
            }
        }
    }
}

extension Visualizer {
    public func warnIfSimulator() {
        #if targetEnvironment(simulator)
            print("[TouchVisualizer] Warning: TouchRadius doesn't work on the simulator because it is not possible to read touch radius on it.", terminator: "")
        #endif
    }
    
    // MARK: - Logging
    public func log(_ touch: UITouch) {
        if !config.showsLog {
            return
        }
        
        var ti = 0
        var viewLogs = [[String:String]]()
        for view in touchViews {
            var index = ""
            
            index = "\(ti)"
            ti += 1
            
            var phase: String!
            switch touch.phase {
            case .began: phase = "B"
            case .moved: phase = "M"
            case .stationary: phase = "S"
            case .ended: phase = "E"
            case .cancelled: phase = "C"
            }
            
            let x = String(format: "%.02f", view.center.x)
            let y = String(format: "%.02f", view.center.y)
            let center = "(\(x), \(y))"
            let radius = String(format: "%.02f", touch.majorRadius)
            viewLogs.append(["index": index, "center": center, "phase": phase, "radius": radius])
        }
        
        var log = ""
        
        for viewLog in viewLogs {
            
            if (viewLog["index"]!).count == 0 {
                continue
            }
            
            let index = viewLog["index"]!
            let center = viewLog["center"]!
            let phase = viewLog["phase"]!
            let radius = viewLog["radius"]!
            log += "Touch: [\(index)]<\(phase)> c:\(center) r:\(radius)\t\n"
        }
        
        if log == previousLog {
            return
        }
        
        previousLog = log
        print(log, terminator: "")
    }
}
