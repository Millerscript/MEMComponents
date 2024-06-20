#
# Be sure to run `pod lib lint MEMComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MEMComponents'
  s.version          = '0.1.0'
  s.summary          = 'My own components to create my apps and to ease the development'
  s.swift_version    = '5.0'
  
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'My own components to create my apps and easing the development as a iOS Swift, UIKit_SwiftUI freelancer.'

  s.homepage         = 'https://github.com/Millerscript/MEMComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Millerscript' => 'millersmosquera@gmail.com' }
  s.source           = { :git => 'https://github.com/Millerscript/MEMComponents.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '15.0'

  s.source_files = 'LibraryComponents/Classes/**/*.{h,m,swift}'
  
  s.resource_bundles = {
   'MEMComponents' => [
      'LibraryComponents/Assets/*.png',
      'LibraryComponents/Classes/**/*.'
   ]
  }

  # s.resource_bundles = {
  #   'MEMComponents' => ['MEMComponents/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Kingfisher', '~> 7.0'
  s.dependency 'MEMBase', '0.1.3'
end
