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
                                         detailDescription: "Default slide in wth .halfscreen width and height")
        
        
        /// Fade in with blur and custom size
        let customBlurFadeInPresentation = JellyFadeInPresentation(backgroundStyle: .blur(effectStyle: .light),
                                                            widthForViewController: .halfscreen,
                                                           heightForViewController: .halfscreen)
        
        let customBlurFadeInObject = DataObject(presentation: customBlurFadeInPresentation ,
                                            titleDescription: "Blurred Fade in",
                                           detailDescription: "Fade in Viewcontroller blurred  background .light")
        
        /// Custom slide in presentation with blur
        let customSlideInPresentation = JellySlideInPresentation(backgroundStyle: .blur(effectStyle: .dark),
                                                          widthForViewController: .halfscreen,
                                                         heightForViewController: .halfscreen)
        
        let customBlurSlideInObject = DataObject(presentation: customSlideInPresentation,
                                             titleDescription: "Blurred Slide in",
                                            detailDescription: "Slide in Viewcontroller with blurred background .dark")
        
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
                                                 detailDescription: "Slide in Viewcontroller with custom corner radius, directions and jelliness")
        
        // Custom SlideOver
        let slideOverPresentation = JellySlideInPresentation(dismissCurve: .linear,
                                                        presentationCurve: .linear,
                                                             cornerRadius: 0,
                                                             backgroundStyle: .dimmed(alpha: 0.5),
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
                              detailDescription: "halfscreen left side slide in menu")
        
        // Custom Alert
        let alertPresentation = JellySlideInPresentation(dismissCurve: .linear,
                                                    presentationCurve: .linear,
                                                         cornerRadius: 15,
                                                      backgroundStyle: .blur(effectStyle: .light),
                                                            jellyness: .jellier,
                                                             duration: .normal,
                                                        directionShow: .top,
                                                     directionDismiss: .top,
                                               widthForViewController: .fullscreen, // Lets use 10000 to see if marginGuards kick in
                                              heightForViewController: .custom(value:200) ,
                                                  horizontalAlignment: .center,
                                                    verticalAlignment: .top,
                                                         marginGuards: UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10))
        
        let alertObject = DataObject(presentation: alertPresentation,
                                 titleDescription: "Custom Notification",
                                detailDescription: "custom alert that comes from the top with blurred transition background")
        
        // ShiftInPresentation
        
        var shiftInPresentation = JellyShiftInPresentation()
        shiftInPresentation.direction = .right
        shiftInPresentation.size = .custom(value: 300)

        let shiftInObject = DataObject(presentation: shiftInPresentation, titleDescription: "Shift in Dimmed", detailDescription: "dimmed, right")
        
        var shiftInBlurred = JellyShiftInPresentation()
        shiftInBlurred.direction = .bottom
        shiftInBlurred.backgroundStyle = .blur(effectStyle: .light)
        shiftInBlurred.size = .custom(value: 300)
        
        let shiftInBlurredObject = DataObject(presentation: shiftInBlurred, titleDescription: "Shift in Blurred", detailDescription: "blurred, bottom")

        
        let data = [defaultFadeInObject,defaultSlideInObject,customBlurFadeInObject,customBlurSlideInObject,customCornerDirectionSlideInObject,slideOver,alertObject, shiftInObject,shiftInBlurredObject]
        
        return data
    }()
}
