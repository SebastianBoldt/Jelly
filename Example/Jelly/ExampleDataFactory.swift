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
        
        /// Default Fade in with custom size
        var defaultFadeInPresentation = Jelly.FadePresentation(size: PresentationSize(width: .halfscreen, height: .halfscreen))
        defaultFadeInPresentation.presentationUIConfiguration.isTapBackgroundToDismissEnabled = false
        let defaultFadeInObject = DataObject(presentation: defaultFadeInPresentation, titleDescription: "Default Fade in Animation", detailDescription: "default values, disabled tap to dismiss")
        
        /// Default slide in with custom size
        let defaultSlideInPresentation = Jelly.CoverPresentation(size: PresentationSize(width: .halfscreen, height: .halfscreen))
        
        let defaultSlideInObject = DataObject(presentation: defaultSlideInPresentation ,
                                          titleDescription: "Default Slide in Animation",
                                         detailDescription: "Default slide in wth .halfscreen width and height")
        
        
        /// Fade in with blur and custom size
        let uiConfiguration = PresentationUIConfiguration(backgroundStyle: .blurred(effectStyle: .light))
        let presentationSize = PresentationSize(width: .halfscreen, height: .halfscreen)
        let customBlurFadeInPresentation = Jelly.FadePresentation(size: presentationSize, ui: uiConfiguration)
        
        let customBlurFadeInObject = DataObject(presentation: customBlurFadeInPresentation ,
                                            titleDescription: "Blurred Fade in",
                                           detailDescription: "Fade in Viewcontroller blurred  background .light")
        
        /// Custom slide in presentation with blur
        let customSlideInPresentation = Jelly.CoverPresentation(uiConfiguration: uiConfiguration, size: presentationSize)
        
        let customBlurSlideInObject = DataObject(presentation: customSlideInPresentation,
                                             titleDescription: "Blurred Slide in",
                                            detailDescription: "Slide in Viewcontroller with blurred background .dark")
        /*
        /// Corner Radius and Jellyness
        let customCornerSlideInPresentation = Jelly.SlideInPresentation(directionShow: .left, cornerRadius: 15,
                                                                        backgroundStyle: .blurred(effectStyle: .dark),
                                                                        spring: .medium,
                                                                        duration: .medium,
                                                            directionDismiss: .right,
                                                      widthForViewController: .halfscreen,
                                                     heightForViewController: .halfscreen)
        
        let customCornerDirectionSlideInObject = DataObject(presentation:customCornerSlideInPresentation ,
                                                  titleDescription: "Blurred Slide in Custom Direction",
                                                 detailDescription: "Slide in Viewcontroller with custom corner radius, directions and jelliness")
        
        // Custom SlideOver
        let slideOverPresentation = Jelly.SlideInPresentation(dismissCurve: .linear,
                                                        presentationCurve: .linear,
                                                             cornerRadius: 0,
                                                             backgroundStyle: .dimmed(alpha: 0.5),
                                                                spring: .none,
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
        let alertPresentation = Jelly.SlideInPresentation(dismissCurve: .linear,
                                                    presentationCurve: .linear,
                                                         cornerRadius: 15,
                                                      backgroundStyle: .blurred(effectStyle: .light),
                                                            spring: .medium,
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
        */
        // ShiftInPresentation
        
        var shiftInPresentation = Jelly.SlidePresentation()
        shiftInPresentation.showDirection = .right
        shiftInPresentation.width = .custom(value: 300)

        let shiftInObject = DataObject(presentation: shiftInPresentation, titleDescription: "Shift in Dimmed", detailDescription: "dimmed, right")
        
        var shiftInBlurred = Jelly.SlidePresentation()
        shiftInBlurred.showDirection = .bottom
        shiftInBlurred.presentationUIConfiguration.backgroundStyle = .blurred(effectStyle: .light)
        shiftInBlurred.width = .custom(value: 300)
        
        let shiftInBlurredObject = DataObject(presentation: shiftInBlurred, titleDescription: "Shift in Blurred", detailDescription: "blurred, bottom")

        
        let data = [defaultFadeInObject,defaultSlideInObject,customBlurFadeInObject,customBlurSlideInObject,/*customCornerDirectionSlideInObject,slideOver,alertObject,*/ shiftInObject,shiftInBlurredObject]
        
        return data
    }()
}
