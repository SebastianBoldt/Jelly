
# Jelly
#### Create rich viewcontroller transition animations with just a few lines of code

![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/feature/2.0.0/Github/Jellyfish.png?raw=true)

<a href="https://cocoapods.org/pods/Jelly"><img src="https://img.shields.io/badge/version-2.0.0-green.svg?longCache=true&style=flat-square" alt="current version" /></a>
<a href="http://twitter.com/sebastianboldt"><img src="https://img.shields.io/badge/twitter-@sebastianboldt-blue.svg?longCache=true&style=flat-square" alt="twitter handle" /></a>
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift4.2-compatible-orange.svg?longCache=true&style=flat-square" alt="Swift 4.2 compatible" /></a>
<a href="https://www.apple.com/de/ios/ios-12/"><img src="https://img.shields.io/badge/platform-iOS-lightgray.svg?longCache=true&style=flat-square" alt="platform" /></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/carthage-compatible-green.svg?longCache=true&style=flat-square" alt="carthage support" /></a>
<a href="https://en.wikipedia.org/wiki/MIT_License"><img src="https://img.shields.io/badge/license-MIT-lightgray.svg?longCache=true&style=flat-square" alt="license" /></a>

Jelly provides custom view controller transitions with just a few lines of code.
No need to create your own Presentation-Controller or Animator objects.
An Animator will do the heavy lifting for you.

```swift

var slidePresentation = SlidePresentation(direction: .left)
let animator = Animator(presentation: slidePresentation)
animator.prepare(viewController: viewController)
present(viewController, animated: true, completion: nil)
```
Slide , Cover , Fade

// Enter new fancy images over here

## How to

Jelly is super easy to use.

1. Create a *Presentation* Object 
2. Initialize a *Animator* using the *Presentation* Object created in Step 1.
3. Call the *prepare(viewController:UIViewController)* Function
4. Finally call the native *UIViewController* presentation function.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    let viewController = YourViewController()
    let presentation = SlidePresentation()
    animator = Animator(presentation:presentation)
    animator?.prepare(viewController: viewController)
    present(viewController, animated: true, completion: nil)
}
```

***DO NOT FORGET TO KEEP A STRONG 💪 REFERENCE***

Because the *transitioningDelegate* of a *UIViewController* is weak, you need to
hold a strong reference to the *Animator* inside the *UIViewController* you are presenting from or the central object that maintains your presentations.

```swift
class CustomVC : UIViewController {
    var animator: Jelly.Animator?
    override func viewDidLoad() {
        super.viewDidLoad()
        var shiftInPresentation = Jelly.ShiftInPresentation()
        shiftInPresentation.direction = .left
        let animator = Jelly.Animator(presentation:presentation)
        self.animator = animator
    }
}
```

## Customize


```swift

```


## Requirements

Deployment target of your App is >= iOS 8.0

## Installation

Jelly is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Jelly"
```
## Mentions

* Mentioned in <i>iOS Dev Weekly</i> by <a href="https://twitter.com/daveverwer">@Dave Verwer</a> - <a href="http://iosdevweekly.com/issues/279"> Issue NO. 112 </a>
* Mentioned in <i>This Week in Swift</i> by <a href="https://twitter.com/NatashaTheRobot">@Natasha the Robot</a> - <a href="https://swiftnews.curated.co/issues/112#start"> Issue No. 279 </a>

## Author

Sebastian Boldt, https://www.sebastianboldt.com

## License

Jelly is available under the MIT license. See the LICENSE file for more info.
