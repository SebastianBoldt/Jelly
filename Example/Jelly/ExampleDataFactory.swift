//
//  ExampleDataProvider.swift
//  Jelly
//
//  Created by Sebastian Boldt on 27.11.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Jelly

struct DataObject {
    let presentation : Jelly.Presentation
    let titleDescription : String
    let detailDescription : String
}

struct ExampleDataProvider {
    var data : [DataObject] = {
        
        let size = PresentationSize(width: .fullscreen, height: .fullscreen)
        let interactionConfiguration = InteractionConfiguration(showDragDirection: .left, dismissDragDirection: .right, dragMode: .edge)
        let presentation = CoverPresentation(directionShow: .left, directionDismiss: .left, size: size, interactionConfiguration: interactionConfiguration)
        let interactiveCoverPresentation = DataObject(presentation: presentation, titleDescription: "Interactive Cover", detailDescription: "cover from the left")
        let data = [interactiveCoverPresentation]
        
        return data
    }()
}
