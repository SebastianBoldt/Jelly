#
# Be sure to run `pod lib lint Jelly.podspec' to ensure this is a valid spec before submitting.
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'Jelly'
    s.version          = '2.2.1'
    s.summary          = 'Jelly is a library for animated, non-interactive & interactive viewcontroller transitions and presentations with the focus on a simple and yet flexible API.'

    s.description      = <<-DESC
        Jelly is a library for animated, non-interactive & interactive viewcontroller
        transitions and presentations with the focus on a simple and yet flexible API.
    DESC

    s.homepage         = 'https://www.sebastianboldt.com'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Sebastian Boldt' => 'self.dealloc@googlemail.com' }
    s.social_media_url = 'http://twitter.com/sebastianboldt'
    s.source           = { :git => 'https://github.com/SebastianBoldt/Jelly.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/sebastianboldt'

    s.ios.deployment_target = '10.0'
    s.source_files = 'Jelly/Classes/**/*'
    s.frameworks = 'UIKit'
end

