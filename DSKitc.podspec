#
# Be sure to run `pod lib lint DSKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DSKitc'
  s.version          = '0.2.0'
  s.summary          = 'Data Structures written in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
DSKit is a Framework of Data Structures written in Swift.
                       DESC

  s.homepage         = 'https://github.com/Li-Bot/DSKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'GNU GPLv3', :file => 'LICENSE' }
  s.author           = { 'Libor Polehna' => 'polehna.libor@gmail.com' }
  s.source           = { :git => 'https://github.com/Li-Bot/DSKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.swift_versions = '5.0'

  s.source_files = 'Sources/**/*.{h,m,swift}'
  
  # s.resource = '.../**/*.{xib,storyboard}'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
