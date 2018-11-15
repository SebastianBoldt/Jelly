![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/master/Github/Jellyfish.png?raw=true)

<a href="https://paypal.me/boldtsebastian"><img src="https://img.shields.io/badge/paypal-donate-blue.svg?longCache=true&style=flat-square" alt="current version" /></a>
<a href="https://cocoapods.org/pods/Jelly"><img src="https://img.shields.io/badge/version-2.0.0-green.svg?longCache=true&style=flat-square" alt="current version" /></a>
<a href="http://twitter.com/sebastianboldt"><img src="https://img.shields.io/badge/twitter-@sebastianboldt-blue.svg?longCache=true&style=flat-square" alt="twitter handle" /></a>
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift4.2-compatible-orange.svg?longCache=true&style=flat-square" alt="Swift 4.2 compatible" /></a>
<a href="https://www.apple.com/de/ios/ios-12/"><img src="https://img.shields.io/badge/platform-iOS-lightgray.svg?longCache=true&style=flat-square" alt="platform" /></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/carthage-compatible-green.svg?longCache=true&style=flat-square" alt="carthage support" /></a>
<a href="https://en.wikipedia.org/wiki/MIT_License"><img src="https://img.shields.io/badge/license-MIT-lightgray.svg?longCache=true&style=flat-square" alt="license" /></a>

Jelly is a library for animated, non-interactive & interactive viewcontroller <br/>
transitions and presentations with the focus on a simple and yet flexible API. 

<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0240.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
  <img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0242.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
  <img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0244.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
  <img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0246.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0248.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
  <img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0250.TRIM.gif?raw=true" width="80" style="display: block;
  float: left; margin-right: 32px">
  <img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0252.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0254.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
  
With a few lines of source code, interactive UIViewController transitions <br/>
and custom resizable UIViewController presentations can be created, <br/>
without the use of the cumbersome UIKit Transitioning API. 

```swift

var slidePresentation = SlidePresentation(direction: .left)
let animator = Animator(presentation: slidePresentation)
animator.prepare(viewController: viewController)
present(viewController, animated: true, completion: nil)
```

<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/how%20to.png?raw=true" width="400">

1. Create a `Presentation` Object 
2. Configure an  `Animator` with the *Presentation*
3. Call the `prepare` Function
4. Use the native `UIViewController` presentation function.

```swift
class ViewController : UIViewController {
    var animator: Jelly.Animator?
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = YourViewController()
        let presentation = SlidePresentation(direction: .left)
        animator = Animator(presentation:presentation)
        animator?.prepare(presentedViewController: viewController)
        present(viewController, animated: true, completion: nil)
    }
}
```

***DO NOT FORGET TO KEEP A STRONG 💪 REFERENCE***

Because the `transitioningDelegate` of a `UIViewController` is weak, you need to
hold a strong reference to the `Animator` inside the `UIViewController` you are presenting from or 
the central object that maintains your presentations.

<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/interactive-transitions.png?raw=true" width="400">

Interactive transitions can be activated for the *slide* and the *cover* transitions. 
If the transitions are to be interactive, only an `InteractionConfiguration` object has to be passed to the presentation. 

  <img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0244.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
  <img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0246.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0248.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
  <img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0250.TRIM.gif?raw=true" width="80" style="display: block;
  float: left; margin-right: 32px">

Here 2 parameters play an important role. First, the `completionThreshold`, which determines the percentage of the animation that is automatically completed as soon as the user finishes the interaction. 
The second parameter is the actual type of interaction. Jelly offers the `.edge` and the `.canvas` type. 
In an `.edge` transition, the user must execute the gesture from the edge of the screen. 
When using the `.canvas` type, gesture recognizers are configured so that direct interaction with the presenting and presented view leads to the transition.

```swift
let viewController = YourViewController()
let interaction = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .edge)
let presentation = SlidePresentation(direction: .right, interactionConfiguration: interaction)
let animator = Animator(presentation: presentation)
animator.prepare(presentedViewController: viewController)

```
<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/update.png?raw=true" width="400">

Jelly 2.0 also provides a new feature called *LIVE UPDATE*. 
Using Jellys  new `Live Update API` it is now possible to update the `alignment`, `size`, `margin-guards` and `corner radius` when the viewcontroller is already visible.

  <img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0252.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">
<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/IMG_0254.TRIM.gif?raw=true" width="80" style="display: block;
  float: left">

These are the new live update functions provided by the Animator. 

* `updateAlignment(alignment: PresentationAlignment, duration: Duration)` - Cover & Fade
* `updateVerticalAlignment(alignment: VerticalAlignment, duration: Duration)` - Cover & Fade
* `updateHorizontalAlignment(alignment: HorizontalAlignment, duration: Duration)` - Cover & Fade
* `updateSize(presentationSize: PresentationSize, duration: Duration)` - Cover & Fade
* `updateWidth(width: Size, duration: Duration)` - Cover, Fade and horizontal Slide
* `updateHeight(height: Size, duration: Duration)` - Cover, Fade and vertical Slide
* `updateMarginGuards(marginGuards: UIEdgeInsets, duration: Duration)` - Cover & Fade
* `updateCorners(radius: CGFloat, corners: CACornerMask, duration: Duration)` - Cover & Fade & Slide

Some of them will throw an exception if used on a not supported presentationType. <br/>
For example: It is currently not possible to update the size on a Slide-Presentation. 

<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/customization.png?raw=true" width="400">

The presentation types can be configured with various settings: 

* `size`
* `margin guards`
* `direction` 
* `horizontal & vertical alignment` 
* `dimmed and blurred backgroundStyle`
* `duration`
* `presentation and dismiss curve`
* `spring damping & velocity` 
* `corner specification` & `corner radius`
* `completion threshold`
* `interactive drag mode` 

Each component is explained in more detail in the <a href="https://github.com/SebastianBoldt/Jelly/wiki/Customization
">Jelly Wiki</a>.  


<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/requirements.png?raw=true" width="400">

Deployment target of your App is >= iOS 11.0

<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/installation.png?raw=true" width="400">


Jelly is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Jelly', '~> 2.0'
```

<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/mentions.png?raw=true" width="400">

* Mentioned in <i>iOS Dev Weekly</i> by <a href="https://twitter.com/daveverwer">@Dave Verwer</a> - <a href="http://iosdevweekly.com/issues/279"> Issue NO. 112 </a>

* Mentioned in <i>This Week in Swift</i> by <a href="https://twitter.com/NatashaTheRobot">@Natasha the Robot</a> - <a href="https://swiftnews.curated.co/issues/112#start"> Issue No. 279 </a>

<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/author.png?raw=true" width="400">

<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/emoji.png?raw=true" width="200">

Sebastian Boldt, https://www.sebastianboldt.com 

I am a mobile software architect and developer specializing in iOS. 
Passionate about creating awesome user experiences, designing beautiful user interfaces, 
and writing maintainable, structured, and best-practice orientated code. 
Continuously trying to improve skills and learn new technologies.

<a href="https://paypal.me/boldtsebastian"><img src="https://img.shields.io/badge/paypal-donate-blue.svg?longCache=true&style=flat-square" alt="current version" /></a>

<img src="https://github.com/SebastianBoldt/Jelly/blob/master/Github/license.png?raw=true" width="400">

Jelly is available under the MIT license. See the LICENSE file for more info.
