@testable import Jelly
import Quick
import Nimble

class JellyAnimatorSpec: QuickSpec {
    let presentedViewController = UIViewController()
    let presentingViewController = UIViewController()
    
    override func spec() {
        describe("After Configuring a JellyAnimator") {
            context("with cover presentation") {
                it("UIViewControllerTransitioningDelegate should return right animationController for presenting") {
                    let coverPresentation = Jelly.CoverPresentation(interactionConfiguration: InteractionConfiguration(presentingViewController: self.presentingViewController, completionThreshold: 0.5, dragMode: .edge))
                    let animator = Jelly.Animator(presentation: coverPresentation)
                    let animationController = animator.animationController(forPresented: self.presentedViewController, presenting: self.presentingViewController, source: self.presentedViewController)
                    expect(animationController is Jelly.CoverAnimator).to(equal(true))
                }
            }
            
            context("with fade presentation") {
                it("UIViewControllerTransitioningDelegate should return right animationController for presenting") {
                    let fadePresentation = Jelly.FadePresentation()
                    let animator = Jelly.Animator(presentation: fadePresentation)
                    let animationController = animator.animationController(forPresented: self.presentedViewController, presenting: self.presentingViewController, source: self.presentedViewController)
                    expect(animationController is Jelly.FadeAnimator).to(equal(true))
                }
            }
            
            context("with slide presentation") {
                it("UIViewControllerTransitioningDelegate should return right animationController for presenting") {
                    let slidePresentation = Jelly.SlidePresentation(interactionConfiguration: InteractionConfiguration(presentingViewController: self.presentingViewController, completionThreshold: 0.5, dragMode: .edge))
                    let animator = Jelly.Animator(presentation: slidePresentation)
                    let animationController = animator.animationController(forPresented: self.presentedViewController, presenting: self.presentingViewController, source: self.presentedViewController)
                    expect(animationController is Jelly.SlideAnimator).to(equal(true))
                }
            }
        }
    }
}
