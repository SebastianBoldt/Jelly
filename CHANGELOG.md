## 2.2.2 (2019-5-8)
- fixed iOS13 issues

## 2.2.1 (2019-5-6)
- decreased minimum deployment target to iOS10

## 2.2.0 (2019-13-4)
- Swift 5.0 adaptions

## 2.1.1 (2018-12-1)
- flashing blur effect bugfix

## 2.1.0 (2018-12-5)
- new parallax option on slide presentations
- interaction configuration can now be constrained by mode (.dismiss, .present)

## 2.0.0 (2018-11-12)
- interactive transitions are now possible
- renamed FadeIn, ShiftIn, and SlideIn to Fade, Slide & Cover
- the animator is now capable of resizing and realigning already presented viewControllers
- presentations will be configured using new dedicated models for size, alignment etc.
- removed the Jelly Prefix from all classes
- extended example app with interactive examples like slide out menu etc.
- minimum deployment target is iOS 10 now, because of UIViewPropertyAnimator
- new Logo and overall design of Jelly related icons and ui

## 1.2.5 (2018-10-02)
- Swift 4.2 support

## 1.2.4 (2017-11-30)
- Swift 4 support
- custom postion option is now available though horizontal and vertical alignment parameters
- fixed dimming view alpha issue

## 1.2.3 (2017-05-26)
- Code cleanup 
- Removed visual format language based code and replaced it using layout anchors
- Carthage support 
- iOS 8 support

## 1.2.2 (2017-01-21)
- Removed .none as backgroundStyle and replaced it with .dimmed and an associated value: .dimmed(alpha: CGFloat)
- Code cleanup 

## 1.2.1 (2017-01-11)
- Fixed issue with background tap dismissal options

## 1.2.0 (2016-12-18)
- There is a new cool animation style called shiftIn Animation. Check out the README to find out more
- Rounding Corners can now be specified unsing the corners property (e.g. presentation.corners = [.leftBottom,rightTop])
- You can disable tap to dismiss by setting isTapBackgroundToDismissEnabled to false
- You can now set properties without using the basic initaliziers
- Code clean up 
- Startet with integrating Unit-Tests


## 1.0.2 (2016-11-27)

  - New size options (fullscreen, halfscreen and custom) for width and height instead of plain CGSize
  - New alignment options for NonFullscreen Presentations
  - New marging guards - if the size you specified is bigger than the screen, the margin guards kick in and will be applied to your vc
  - If you want to size your vc using margin you can use .fullscreen as a size and set the marginGuards to constraint your vcs dimensions
  - Better Code documentation and overall structure
  - Even more Example inside the Readme and Example App

## 1.0.1 (2016-11-20)

Minor Version update:

  - updated version number so Cocoapods can reflect all changes made in the Readme File

## 1.0 (2016-11-20)

  - 1.0 Provides SlideIn and FadeIn Transitions
  - Customization Options like corner-radius, background style included
  - code cleanup 
