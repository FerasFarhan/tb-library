#
# Be sure to run `pod lib lint tb-library.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "tb-library"
  s.version          = "0.1.1"
s.summary          = "This is Techband all external libraries"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "This pod will be used instead copying all needed files from project to another maually"
 s.platform     = :ios
  s.homepage         = "https://github.com/FerasFarhan/tb-library"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author           = { "Feras Farhan" => "https://github.com/FerasFarhan" }
  s.source           = { :git => "https://github.com/FerasFarhan/tb-library.git", :tag => "0.1.1"}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.requires_arc = true
  s.source_files = 'tb-library/Classes/**/*'
  s.resource_bundles = {
    'tb-library' => ['tb-library/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
