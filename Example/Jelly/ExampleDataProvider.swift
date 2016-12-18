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
    let presentation : JellyPresentation
    let titleDescription : String
    let detailDescription : String
}

struct ExampleDataProvider {
    var data : [DataObject] = {
        
        /// Default Fade in with custom size
        var defaultFadeInPresentation = JellyFadeInPresentation(widthForViewController: .halfscreen,
                                                               heightForViewController: .halfscreen)
        defaultFadeInPresentation.isTapBackgroundToDismissEnabled = false
        let defaultFadeInObject = DataObject(presentation: defaultFadeInPresentation, titleDescription: "Default Fade in Animation", detailDescription: "default values, disabled tap to dismiss")
        
        /// Default slide in with custom size
        let defaultSlideInPresentation = JellySlideInPresentation(widthForViewController: .halfscreen,
                                                                 heightForViewController: .halfscreen)
        
        let defaultSlideInObject = DataObject(presentation: defaultSlideInPresentation ,
                                          titleDescription: "Default Slide in Animation",
                                         detailDescription: "default values")
        
        
        /// Fade in with blur and custom size
        let customBlurFadeInPresentation = JellyFadeInPresentation(backgroundStyle: .blur(effectStyle: .light),
                                                            widthForViewController: .halfscreen,
                                                           heightForViewController: .halfscreen)
        
        let customBlurFadeInObject = DataObject(presentation: customBlurFadeInPresentation ,
                                            titleDescription: "Blurred Fade in",
                                           detailDescription: "blurred  background .light")
        
        /// Custom slide in presentation with blur
        let customSlideInPresentation = JellySlideInPresentation(backgroundStyle: .blur(effectStyle: .dark),
                                                          widthForViewController: .halfscreen,
                                                         heightForViewController: .halfscreen)
        
        let customBlurSlideInObject = DataObject(presentation: customSlideInPresentation,
                                             titleDescription: "Blurred Slide in",
                                            detailDescription: "blurred background .dark")
        
        /// Corner Radius and Jellyness
        let customCornerSlideInPresentation = JellySlideInPresentation(cornerRadius: 15,
                                                             backgroundStyle: .blur(effectStyle: .dark),
                                                                   jellyness: .jellier,
                                                                    duration: .medium,
                                                               directionShow: .left,
                                                            directionDismiss: .right,
                                                      widthForViewController: .halfscreen,
                                                     heightForViewController: .halfscreen)
        
        let customCornerDirectionSlideInObject = DataObject(presentation:customCornerSlideInPresentation ,
                                                  titleDescription: "Blurred Slide in Custom Direction",
                                                 detailDescription: "custom corner radius, directions and jelliness")
        
        // Custom SlideOver
        let slideOverPresentation = JellySlideInPresentation(dismissCurve: .linear,
                                                        presentationCurve: .linear,
                                                             cornerRadius: 0,
                                                          backgroundStyle: .dimmed,
                                                                jellyness: .none,
                                                                 duration: .normal,
                                                            directionShow: .left,
                                                         directionDismiss: .left,
                                                   widthForViewController: .halfscreen,
                                                  heightForViewController: .fullscreen,
                                                      horizontalAlignment: .left,
                                                        verticalAlignment: .top)
        
        let slideOver = DataObject(presentation: slideOverPresentation,
                               titleDescription: "SlideOver",
                              detailDescription: "Yes")
        
        // Custom Alert
        let alertPresentation = JellySlideInPresentation(dismissCurve: .linear,
                                                    presentationCurve: .linear,
                                                         cornerRadius: 15,
                                                      backgroundStyle: .blur(effectStyle: .light),
                                                            jellyness: .jellier,
                                                             duration: .normal,
                                                        directionShow: .top,
                                                     directionDismiss: .top,
                                               widthForViewController: .custom(value:10000), // Lets use 10000 to see if marginGuards kick in
                                              heightForViewController: .custom(value:200) ,
                                                  horizontalAlignment: .center,
                                                    verticalAlignment: .top,
                                                         marginGuards: UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10))
        
        let alertObject = DataObject(presentation: alertPresentation,
                                 titleDescription: "Custom Alert",
                                detailDescription: "Custom Alert")
        
        // ShiftInPresentation
        
        var shiftInPresentation = JellyShiftInPresentation()
        shiftInPresentation.direction = .right
        let shiftInObject = DataObject(presentation: shiftInPresentation, titleDescription: "Shift in", detailDescription: "default shift in presentation")
        
        let data = [shiftInObject, defaultFadeInObject,defaultSlideInObject,customBlurFadeInObject,customBlurSlideInObject,customCornerDirectionSlideInObject,slideOver,alertObject]
        
        return data
    }()
}
