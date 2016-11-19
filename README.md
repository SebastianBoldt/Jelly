# Jelly-Animators (Under Construction)

![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://github.com/SebastianBoldt/Jelly-Animators/blob/master/Github/Jellyfish.png)

[![CI Status](https://travis-ci.org/SebastianBoldt/Jelly-Animators.svg?style=flat)](https://travis-ci.org/SebastianBoldt/Jelly-Animators)
[![Version](https://img.shields.io/cocoapods/v/Jelly-Animators.svg?style=flat)](http://cocoapods.org/pods/Jelly-Animators)
[![License](https://img.shields.io/cocoapods/l/Jelly-Animators.svg?style=flat)](http://cocoapods.org/pods/Jelly-Animators)
[![Platform](https://img.shields.io/cocoapods/p/Jelly-Animators.svg?style=flat)](http://cocoapods.org/pods/Jelly-Animators)
[![Twitter](https://img.shields.io/badge/twitter-@sebastianboldt-blue.svg?style=flat)](http://twitter.com/sebastianboldt)

Jelly Animators provide custom view controller animations with just a few lines of code. 
No need to create your own PresentationController or Animator-Objects.
A Jelly-Animator will do the heavy lifting for you.

## How to use 

Jelly Animators are super easy to use. 
1. Create a JellyPresentation Object
2. Initialize a JellyAnimator using the JellyPresentation Object create in Step 1.
3. Call the prepare Function
4. Finally call the native UIViewController presentation function.

```swift
// 1.
let finalSize = CGSize(width: 200, height: 500)
let presentation = JellyPresentation(jellyness: .jelly,
                                      duration: .ultraSlow,
                                 directionShow: .left,
                              directionDismiss: .top,
                                         style: .slidein,
                                         curve: .EaseInEaseOut,
                         sizeForViewController: finalSize,
                               showDimmingView: false,
                                  cornerRadius: 10)
// 2.          
self.jellyAnimator = JellyAnimator(presentation:presentation)
// 3.
self.jellyAnimator?.prepare(viewController: viewController)
// 4.
self.present(viewController, animated: true, completion: nil)
```

***YOU NEED TO KEEP A STRONG REFERENCE***

```swift 
class CustomVC : UIViewController {
  var jellyAnimator: JellyAnimator?
  override func viewDidLoad() {
        super.viewDidLoad()
        // Setup your Animator here 
        // ....
        // And assign it
        self.jellyAnimator = createdAnimator.
  }
}
```
Because the transitioningDelegate of a ViewController is weak, you need to 
hold a strong reference to the JellyAnimator inside the ViewController you are presenting from

That's it

## Example App

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Jelly-Animators is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Jelly-Animators"
```

## Author

Sebastian Boldt, self.dealloc@googlemail.com

## License

Jelly-Animators is available under the MIT license. See the LICENSE file for more info.
