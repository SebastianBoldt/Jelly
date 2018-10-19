//
//  DynamicPresentation.swift
//  Jelly
//
//  Created by Sebastian Boldt on 19.10.18.
//

import Foundation

public protocol DynamicPresentation {
    var widthForViewController: JellyConstants.Size { get set  }
    var heightForViewController: JellyConstants.Size { get set }
    /// If the width or height is bigger than the container we are working in, marginGuards will kick in and limit the size the specified margins
    var marginGuards: UIEdgeInsets { get set }
}
