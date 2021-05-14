#
# Be sure to run `pod lib lint SMLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SMLibrary'
  s.version          = '0.2.3'
  s.summary          = 'iOS 개발 시 자주 사용한 기능 모음'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'iOS App 개발 시 자주 사용하는 기능들의 모았으며 지속적으로 추가할 예정입니다.'

  s.homepage         = 'https://github.com/blairSeo/SMLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'blairSeo' => 'blair.seo.0223@gmail.com' }
  s.source           = { :git => 'https://github.com/blairSeo/SMLibrary.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'SMLibrary/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SMLibrary' => ['SMLibrary/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Alamofire'
  s.dependency 'SwiftLint'
end
