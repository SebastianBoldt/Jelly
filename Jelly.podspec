#
# Be sure to run `pod lib lint Jelly.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'Jelly'
s.version          = '1.0'
s.summary          = 'Jelly provides custom view controller animations with just a few lines of code'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
Jelly is a simple to use Animation-Library
It helps you to add rich animations to your app without writing boiler code over and over
DESC

s.homepage         = 'https://github.com/SebastianBoldt/Jelly'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Sebastian Boldt' => 'self.dealloc@googlemail.com' }
s.social_media_url = 'http://twitter.com/sebastianboldt'
s.source           = { :git => 'https://github.com/SebastianBoldt/Jelly.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/sebastianboldt'

s.ios.deployment_target = '8.0'

s.source_files = 'Jelly/Classes/**/*'

# s.resource_bundles = {
#   'Jelly-Animators' => ['Jelly-Animators/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit'
# s.dependency 'AFNetworking', '~> 2.3'
end

