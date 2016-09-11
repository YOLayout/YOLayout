#
#  Be sure to run `pod spec lint YOLayout.podspec` to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "YOLayout"
  s.version      = "0.2.14"
  s.summary      = "Layout framework."
  s.homepage     = "https://github.com/YOLayout/YOLayout"
  s.license      = "MIT"
  s.authors      = { "Gabriel Handford" => "gabrielh@gmail.com",
                     "John Boiles" => "johnaboiles@gmail.com" }
  s.source       = { :git => "https://github.com/YOLayout/YOLayout.git", :tag => s.version.to_s }

  s.requires_arc = true

  s.ios.deployment_target = "7.0"
  s.ios.source_files = "YOLayout/*.{h,m}", "YOLayout/UIKit/*.{h,m}", "YOLayout/Box/*.{h,m}", "YOLayout/Layouts/*.{h,m}"

  s.osx.deployment_target = "10.8"
  s.osx.source_files = "YOLayout/*.{h,m}", "YOLayout/AppKit/*.{h,m}", "YOLayout/Box/*.{h,m}", "YOLayout/Layouts/*.{h,m}"

end
