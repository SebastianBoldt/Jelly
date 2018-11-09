//
//  Configuration.swift
//  TouchVisualizer
//

import UIKit

public struct Configuration {
    private struct Constants {
        static let defaultColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 0.8)
    }

    /**
    Color of touch points
    */
    public var color: UIColor? = Constants.defaultColor

    // Image of touch points
    public var image: UIImage? = {
        let rect = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0)

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let contextRef = UIGraphicsGetCurrentContext()
        contextRef?.setFillColor(Constants.defaultColor.cgColor)
        contextRef?.fillEllipse(in: rect)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image?.withRenderingMode(.alwaysTemplate)
    }()

    /**
    Default touch point size. If `showsTouchRadius` is enabled, this value is ignored
    */
    public var defaultSize = CGSize(width: 60.0, height: 60.0)

    /**
    Shows touch duration.
    */
    public var showsTimer = false

    /**
    Shows touch radius. It doesn't work on simulator because it is not
    possible to read touch radius on it. Please test it on device
    */
    public var showsTouchRadius = false

    /**
    Shows log. This will affect performance. Make sure showing logs only in development environment
    */
    public var showsLog = false

    public init(){}
}
