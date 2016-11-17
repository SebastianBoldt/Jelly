![Jelly-Animators: Elegant Viewcontroller Animations in Swift](https://raw.githubusercontent.com/SebastianBoldt/Jelly-Animators/develop/Github/Jelly-Animators.png)

# Jelly-Animators (Under Construction)
[![CI Status](https://travis-ci.org/SebastianBoldt/Jelly-Animators.svg?style=flat)](https://travis-ci.org/SebastianBoldt/Jelly-Animators)
[![Version](https://img.shields.io/cocoapods/v/Jelly-Animators.svg?style=flat)](http://cocoapods.org/pods/Jelly-Animators)
[![License](https://img.shields.io/cocoapods/l/Jelly-Animators.svg?style=flat)](http://cocoapods.org/pods/Jelly-Animators)
[![Platform](https://img.shields.io/cocoapods/p/Jelly-Animators.svg?style=flat)](http://cocoapods.org/pods/Jelly-Animators)
[![Twitter](https://img.shields.io/badge/twitter-@sebastianboldt-blue.svg?style=flat)](http://twitter.com/sebastianboldt)

Jelly Animators provide custom view controller animations with just a few lines of code.
You specify the style, jellyness, and duration of the animation and the final size of the presented ViewController.
A Jelly-Animator will do the rest for you.

## How to use 

Jelly Animators are super easy to use. You just create a JellyPresentation Object,
initialize a JellyAnimator using this presentation, prepare your vc using that JellyAnimator 
and finally call the native UIViewController presentation function.

***YOU NEED TO KEEP A STRONG REFERENCE***

Because the transitioningDelegate of a ViewController is weak, you need to 
hold a strong reference to the Animator

That's it

```swift
let finalSize = CGSize(width: 200, height: 500)
let presentation = JellyPresentation(jellyness: .jelly,
                                      duration: .medium,
                                     direction: .left, style: .slidein,
                         sizeForViewController: finalSize,
                               showDimmingView: false,
                                  cornerRadius: 10)

self.jellyAnimator = JellyAnimator(presentation:presentation)
self.jellyAnimator?.prepare(viewController: viewController)
self.present(viewController, animated: true, completion: nil)
```

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
