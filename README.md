
# Jelly
#### Create rich viewcontroller transition animations with just a few lines of code

![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/master/Github/Jellyfish.png)

[![CI Status](https://travis-ci.org/SebastianBoldt/Jelly.svg?branch=master)](https://travis-ci.org/SebastianBoldt/Jelly)
[![Version](https://img.shields.io/cocoapods/v/Jelly.svg?style=flat)](http://cocoapods.org/pods/Jelly)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Jelly.svg?style=flat)](http://cocoapods.org/pods/Jelly)
[![Platform](https://img.shields.io/cocoapods/p/Jelly.svg?style=flat)](http://cocoapods.org/pods/Jelly)
[![Twitter](https://img.shields.io/badge/twitter-@sebastianboldt-blue.svg?style=flat)](http://twitter.com/sebastianboldt)
[![codebeat badge](https://codebeat.co/badges/dae39b83-80b4-44a2-9400-3edc331ced70)](https://codebeat.co/projects/github-com-sebastianboldt-jelly)
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-orange.svg?style=flat" alt="Swift 3 compatible" /></a>

Jelly provides custom view controller transitions with just a few lines of code.
No need to create your own Presentation-Controller or Animator objects.
A Jelly-Animator will do the heavy lifting for you.

## 📱 Example

You can use Jelly to build your own Alertviews or Slidein-Menus using ViewControllers designed by yourself.

![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/master/Github/notification.gif?raw=true)   ![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/master/Github/slideover.gif?raw=true)

![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/master/Github/shiftindimmed.gif?raw=true)  ![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/master/Github/shiftinblurred.gif?raw=true)

![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/master/Github/fadin.gif?raw=true)  ![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/master/Github/blurredslidein.gif?raw=true)


To run the example project, clone  the repo, and run `pod install` from the Example directory first.

## 🔧How to use

Jelly is super easy to use.

1. Create a *JellyPresentation* Object (SlideIn, FadeIn or ShiftIn)
2. Initialize a *JellyAnimator* using the *JellyPresentation* Object created in Step 1.
3. Call the *prepare(viewController:UIViewController)* Function
4. Finally call the native *UIViewController* presentation function.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    let viewController = self.storyboard.instantiateViewController(withIdentifier: "someViewController")
    //1.
    let presentation = JellySlideInPresentation()
    //2.
    self.jellyAnimator = JellyAnimator(presentation:presentation)
    //3.
    self.jellyAnimator?.prepare(viewController: viewController)
    //4.
    self.present(viewController, animated: true, completion: nil)
}

```

***DO NOT FORGET TO KEEP A STRONG 💪 REFERENCE***

Because the *transitioningDelegate* of a *UIViewController* is weak, you need to
hold a strong reference to the *JellyAnimator* inside the *UIViewController* you are presenting from or the central object that maintains your presentations.

```swift
class CustomVC : UIViewController {
    var jellyAnimator: JellyAnimator?
    override func viewDidLoad() {
        super.viewDidLoad()
        var shiftInPresentation = JellyShiftInPresentation()
        shiftInPresentation.direction = .left
        let animator = JellyAnnimator(presentation:presentation)
        self.jellyAnimator = animator
    }
}
```

That's it. That's lit.

## 🖌 Customize
Jelly offers 3 types of Presentations for you:
* **JellySlideInPresentation**
* **JellyShiftInPresentation**
* **JellyFadeInPresentation**

Not every property is available for each animation.
Check out the interfaces of each class to learn more about them.

* **duration:** JellyConstants.Duration (default: normal)
    * ultraSlow = 2.0
    * slow = 1.0
    * medium = 0.5
    * normal = 0.35
    * fast = 0.2
    * reallyFast = 0.1
* **backgroundStyle:** JellyConstants.BackgroundStyle (default: .dimmed(0.5))
    * dimmed(alpha: CGFloat)
    * blur(effectStyle: UIBlurEffectStyle)
    * if you want a transparent background use .dimmed(alpha:0.0)
* **cornerRadius:** Double (default: 0)
* **corners:** UIRectCorner (default: .allCorners)
    * define which corners the radius should be applied to
* **presentationCurve:** JellyConstants.JellyCurve (default: linear)
    * easeIn
    * easeOut
    * easeInEaseOut
    * linear
* **dismissCurve:** JellyConstants.JellyCurve (default: linear)
    * easeIn
    * easeOut
    * easeInEaseOut
    * linear
* **isTapBackgroundToDismissEnabled** (default: true)
    * tapping the background dismisses the ViewController by default
    * set it to false to prevent this behavior
* **widthForViewController:** JellyConstants.Size (default: fullscreen)
    * If the container is smaller than the provided width, Jelly will automatically resize to the containers width
    * if Margin Guards are specified they also will be applied if width is to wide for the container
* **heightForViewController:** JellyConstants.Size (default: fullscreen)
    * If the container is smaller than the provided height, Jelly will automatically resize to the containers width
    * if Margin Guards are specified they also will be applied when height is to high for the container
* **horizontalAlignment:** JellyConstants.HorizontalAlignment (default: .center)
    * center, left or right
* **verticalAlignemt:** JellyConstants.VerticalAlignment (default:center)
    * top, bottom, center
* **marginGuards:** default(UIEdgeInsets.zero)
    * If the width or height is bigger than the container we are working with, marginGuards will kick in and limit the size using the specified margins
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
                                                         marginGuards: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                                              corners: [.topLeft,.bottomRight])


self.jellyAnimator = JellyAnimator(presentation:customPresentation)
self.jellyAnimator?.prepare(viewController: viewController)
self.present(viewController, animated: true, completion: nil)
```

## ✅ Requirements

Deployment target of your App is >= iOS 9.0

## 📲 Installation

Jelly is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Jelly"
```
## 🗣 Mentions

* Mentioned in <i>iOS Dev Weekly</i> by <a href="https://twitter.com/daveverwer">@Dave Verwer</a> - <a href="http://iosdevweekly.com/issues/279"> Issue NO. 112 </a>
* Mentioned in <i>This Week in Swift</i> by <a href="https://twitter.com/NatashaTheRobot">@Natasha the Robot</a> - <a href="https://swiftnews.curated.co/issues/112#start"> Issue No. 279 </a>

## 🤖 Author

Sebastian Boldt, self.dealloc@googlemail.com

## 📄 License

Jelly is available under the MIT license. See the LICENSE file for more info.
