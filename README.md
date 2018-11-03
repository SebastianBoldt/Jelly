![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly/blob/feature/2.0.0/Github/Jellyfish.png?raw=true)

<a href="https://cocoapods.org/pods/Jelly"><img src="https://img.shields.io/badge/version-2.0.0-green.svg?longCache=true&style=flat-square" alt="current version" /></a>
<a href="http://twitter.com/sebastianboldt"><img src="https://img.shields.io/badge/twitter-@sebastianboldt-blue.svg?longCache=true&style=flat-square" alt="twitter handle" /></a>
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift4.2-compatible-orange.svg?longCache=true&style=flat-square" alt="Swift 4.2 compatible" /></a>
<a href="https://www.apple.com/de/ios/ios-12/"><img src="https://img.shields.io/badge/platform-iOS-lightgray.svg?longCache=true&style=flat-square" alt="platform" /></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/carthage-compatible-green.svg?longCache=true&style=flat-square" alt="carthage support" /></a>
<a href="https://en.wikipedia.org/wiki/MIT_License"><img src="https://img.shields.io/badge/license-MIT-lightgray.svg?longCache=true&style=flat-square" alt="license" /></a>

Jelly is a library for animated, interactive viewcontroller transitions with the focus on a simple and yet flexible API. 

```swift

var slidePresentation = SlidePresentation(direction: .left)
let animator = Animator(presentation: slidePresentation)
animator.prepare(viewController: viewController)
present(viewController, animated: true, completion: nil)
```

## How to

1. Create a *Presentation* Object 
2. Configure an  *Animator* with the *Presentation*
3. Call the *prepare* Function
4. Use the native *UIViewController* presentation function.

```swift
class ViewController : UIViewController {
    var animator: Jelly.Animator?
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = YourViewController()
        let presentation = SlidePresentation()
        animator = Animator(presentation:presentation)
        animator?.prepare(viewController: viewController)
        present(viewController, animated: true, completion: nil)
    }
}
```

***DO NOT FORGET TO KEEP A STRONG 💪 REFERENCE***

Because the *transitioningDelegate* of a *UIViewController* is weak, you need to
hold a strong reference to the *Animator* inside the *UIViewController* you are presenting from or 
the central object that maintains your presentations.

## Interactive Transitions

Interactive transitions can be activated for the slide and the cover transitions. 
If the transitions are to be interactive, only an interaction configuration object has to be passed to the presentation. 
Here 2 parameters play an important role. First, the completion threshold, which determines the percentage of the animation that is automatically completed as soon as the user finishes the interaction. 
The second parameter is the type of interaction, Jelly offers the Edge and the Canvas Type. 
In an edge transition, the user must execute the gesture from the edge of the screen. 
When using the Canvas Type, Gesture Recognizers are configured so that direct interaction with the presenting and presented view leads to the transition.

```swift

let interaction = InteractionConfiguration(completionThreshold: 0.5, dragMode: .edge)
let presentation = SlidePresentation(direction: .right, width: .halfscreen)
let animator = Animator(presentation: presentation)
let viewController = YourViewController()
animator.prepare(presentedViewController: viewController, presentingViewController: self)

```
## Customization

The presentation types can be configured with various settings. 
These include size, direction, timing, user interface configurations and interaction configuration. 
Each component is explained in more detail in the Jelly Wiki.  

## Requirements

Deployment target of your App is >= iOS 10.0

## Installation

Jelly is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Jelly', '~> 2.0'
```
## Mentions

* Mentioned in <i>iOS Dev Weekly</i> by <a href="https://twitter.com/daveverwer">@Dave Verwer</a> - <a href="http://iosdevweekly.com/issues/279"> Issue NO. 112 </a>
* Mentioned in <i>This Week in Swift</i> by <a href="https://twitter.com/NatashaTheRobot">@Natasha the Robot</a> - <a href="https://swiftnews.curated.co/issues/112#start"> Issue No. 279 </a>

## Author

Sebastian Boldt, https://www.sebastianboldt.com

I am a mobile software architect and developer specializing in iOS. 
Passionate about creating awesome user experiences, designing beautiful user interfaces, 
and writing maintainable, structured, and best-practice orientated code. 
Continuously trying to improve skills and learn new technologies.

## License

Jelly is available under the MIT license. See the LICENSE file for more info.
