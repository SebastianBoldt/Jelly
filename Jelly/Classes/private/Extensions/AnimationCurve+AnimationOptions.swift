//
//  AnimationCurve+AnimationOptions.swift
//  Jelly
//
//  Created by Sebastian Boldt on 29.10.18.
//

import UIKit

extension UIView.AnimationCurve {
    var animationOptions: UIView.AnimationOptions {
        switch (self) {
            case .easeInOut: return UIView.AnimationOptions.curveEaseInOut
            case .easeIn: return UIView.AnimationOptions.curveEaseIn
            case .easeOut: return UIView.AnimationOptions.curveEaseOut
            case .linear: return UIView.AnimationOptions.curveLinear
        }
    }
}

