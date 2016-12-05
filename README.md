# Jelly
#### Custom Viewcontroller animations with just a few lines of code

![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/master/Github/Jellyfish.png)

[![CI Status](https://travis-ci.org/SebastianBoldt/Jelly.svg?style=flat)](https://travis-ci.org/SebastianBoldt/Jelly)
[![Version](https://img.shields.io/cocoapods/v/Jelly.svg?style=flat)](http://cocoapods.org/pods/Jelly)
[![License](https://img.shields.io/cocoapods/l/Jelly.svg?style=flat)](http://cocoapods.org/pods/Jelly)
[![Platform](https://img.shields.io/cocoapods/p/Jelly.svg?style=flat)](http://cocoapods.org/pods/Jelly)
[![Twitter](https://img.shields.io/badge/twitter-@sebastianboldt-blue.svg?style=flat)](http://twitter.com/sebastianboldt)
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-orange.svg?style=flat" alt="Swift 3 compatible" /></a>

Jelly provides custom view controller transitions with just a few lines of code. 
No need to create your own PresentationController or Animator-Objects.
A Jelly-Animator will do the heavy lifting for you.

## Example 📱

You can use Jelly to build your own Alert-Views or Slidein-Menus using ViewControllers designed by yourself.

![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/release/1.0.2/Github/notification.gif?raw=true)   ![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/release/1.0.2/Github/slideover.gif?raw=true) 


![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/release/1.0.2/Github/fadin.gif?raw=true)  ![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/release/1.0.2/Github/blurredslidein.gif?raw=true)


To run the example project, clone  the repo, and run `pod install` from the Example directory first.

## How to use 🔧

Jelly is super easy to use. 

1. Create a *JellyPresentation* Object
2. Initialize a *JellyAnimator* using the *JellyPresentation* Object created in Step 1.
3. Call the *prepare(viewController:UIViewController)* Function
4. Finally call the native *UIViewController* presentation function.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    let viewController = self.storyboard.instantiateViewController(withIdentifier: "someViewController")
    let presentation = JellySlideInPresentation()
    self.jellyAnimator = JellyAnimator(presentation:presentation)
    self.jellyAnimator?.prepare(viewController: viewController)
    self.present(viewController, animated: true, completion: nil)
}

```

***DO NOT FORGET TO KEEP A STRONG 💪 REFERENCE***

Because the *transitioningDelegate* of a *UIViewController* is weak, you need to 
hold a strong reference to the *JellyAnimator* inside the *UIViewController* you are presenting from

```swift 
class CustomVC : UIViewController {
    var jellyAnimator: JellyAnimator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup your Animator here 
        // ....
        // And assign it
        self.jellyAnimator = createAnimator()
    }
}
```

That's it. That's lit.

## Customize 🖌
Jelly Supports two types of Presentations.
* **JellySlideInPresentation**
* **JellyFadeInPresentation**

Both share some propertys and each Property has a default value 
* **duration:** JellyConstants.Duration (default: normal)
    * ultraSlow = 2.0
    * slow = 1.0
    * medium = 0.5
    * normal = 0.35
    * fast = 0.2
    * reallyFast = 0.1
* **widthForViewController:** JellyConstants.Size (default: fullscreen)
    * If the container is smaller than the provided width Jelly will automatically resize to the containers width
    * if Margin Guards are specified they also will be applied if width is to wide for the container
* **heightForViewController:** JellyConstants.Size (default: fullscreen)
    * If the container is smaller than the provided height Jelly will automatically resize to the containers width
    * if Margin Guards are specified they also will be applied when height is to high for the container
* **horizontalAlignment:** JellyConstants.HorizontalAlignment (default: .center)
    * center, left or right
* **verticalAlignemt:** JellyConstants.VerticalAlignment (default:center)
    * top, bottom, center
* **marginGuards:** default(UIEdgeInsets.zero)
    * If the width or height is bigger than the container we are working with, marginGuards will kick in and limit the size using the specified margins
* **backgroundStyle:** JellyConstants.BackgroundStyle (default: dimmed)
    * dimmed, blur(effectStyle), none
* **cornerRadius:** Double (default: 0)
* **presentationCurve:** JellyConstants.JellyCurve (default: linear)
    * easeIn, easeOut, easeInEaseOut, linear
* **dismissCurve:** JellyConstants.JellyCurve (default: linear)
    * easeIn, easeOut, easeInEaseOut, linear

**JellyFadeInAnimation provides 3 extra Properties**

* **directionShow:** JellyConstants.Direction (default: top)
    * left, top, bottom, right
* **directionDismiss:** JellyConstants.Direction (default: top)
    * left, top, bottom, right
* **jellyness:** (default: none)
    * none (damping = 1.0, velocity = 0.0)
    * jelly (damping = 0.7, velocity = 2)
    * jellier (damping = 0.5 , velocity = 3)
    * jelliest (damping = 0.2, velocity = 4)

```swift

let customPresentation = JellySlideInPresentation(dismissCurve: .linear,
                                                    presentationCurve: .linear,
                                                         cornerRadius: 15,
                                                      backgroundStyle: .blur(effectStyle: .light),
                                                            jellyness: .jellier,
                                                             duration: .normal,
                                                        directionShow: .top,
                                                     directionDismiss: .top,
                                               widthForViewController: .fullscreen, 
                                              heightForViewController: .custom(value:200) ,
                                                  horizontalAlignment: .center,
                                                    verticalAlignment: .top,
                                                         marginGuards: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))


self.jellyAnimator = JellyAnimator(presentation:customPresentation)
self.jellyAnimator?.prepare(viewController: viewController)
self.present(viewController, animated: true, completion: nil)
```

## Requirements

Your Project at least needs a deployment target that is > iOS 9.0

## Installation

Jelly is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Jelly"
```
## Mentions

* Mentioned in This Week in Swift by <a href="https://twitter.com/daveverwer">@Dave Verwer</a> - <a href="http://iosdevweekly.com/issues/279"> Issue NO. 112 </a>
* Mentioned in iOS Dev Weekly by <a href="https://twitter.com/NatashaTheRobot">Natasha the Robot</a> - <a href="https://swiftnews.curated.co/issues/112#start"> Issue No. 279 </a>

## Author

Sebastian Boldt, self.dealloc@googlemail.com

## License

Jelly is available under the MIT license. See the LICENSE file for more info.
