Pod::Spec.new do |s|
  s.name             = 'HATHandyKit'
  s.version          = '0.1.0'
  s.summary          = 'HATHandyKit pod for some project.'
  s.description      = <<-DESC
This is just an simple pod, use for my HAT progress.
                       DESC
					   
  s.homepage         = 'https://github.com/bugs2/HATHandyKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'proprietary', :file => 'LICENSE' }
  s.author           = { 'bugs2' => 'mcckoy@qq.com' }
  s.source           = { :git => 'https://github.com/bugs2/HATHandyKit.git', :tag => s.version }
 # s.social_media_url = 'https://twitter.com/ericksli'
  s.platform = :ios, '8.0'
  s.source_files = 'HATHandyKit/**/*.{h,m}'
  
  #s.resource_bundles = {
  #  'HATHandyKit' => ['HATHandyKit/**/*.{storyboard,xib}']
  #}
  #s.public_header_files = [
  #  'MyOwnPod/MyClassA.h',
  #  'MyOwnPod/MyClassB.h'
  #]
  s.frameworks = 'UIKit', 'CoreGraphics'
  #s.library = 'xml2'
  #s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  s.dependency 'Masonry'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
 
 end