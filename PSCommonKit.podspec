#
# Be sure to run `pod lib lint PSCommonKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
# pod trunk push PSCommonKit.podspec --allow-warnings --verbose

Pod::Spec.new do |s|
  s.name             = 'PSCommonKit'
  s.version          = '0.1.2'
  s.summary          = 'A short description of PSCommonKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/paintingStyle/PSCommonKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'paintingStyle' => 'renshuangfu@spap.com' }
  s.source           = { :git => 'https://github.com/paintingStyle/PSCommonKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PSCommonKit/Classes/**/*'
  s.frameworks = 'UIKit'
	
  # s.resource_bundles = {
  #   'PSCommonKit' => ['PSCommonKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
