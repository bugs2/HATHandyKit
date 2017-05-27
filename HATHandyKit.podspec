 Pod::Spec.new do |s|
  s.name             = 'HATHandyKit'
  s.version          = '0.15.0'
  s.summary          = 'HATHandyKit pod for some project.'
  s.description      = <<-DESC
This is just an simple pod, use for my HAT progress.
                       DESC
					   
  s.homepage         = 'https://github.com/bugs2/HATHandyKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'proprietary', :file => 'LICENSE' }
  s.author           = { 'bugs2' => 'mcckoy@qq.com' }
  s.source           = { :git => 'https://github.com/bugs2/HATHandyKit.git', :tag => s.version }
  s.social_media_url = 'https://github.com/bugs2'
  s.platform = :ios, '8.0'
  
 #项目中分组显示, 得如下配置
 	 s.subspec 'Default' do |ss|
	     ss.public_header_files = 'HATHandyKit/*.h'
         ss.source_files        = 'HATHandyKit/*.{h,m}'
     end

     s.subspec 'HATAlertView' do |ss|
	     ss.public_header_files = 'HATHandyKit/HATAlertView/*.h'
         ss.source_files     = 'HATHandyKit/HATAlertView/*.{h,m}'
     end

     
  #s.source_files = 'HATHandyKit/**/*.{h,m}'
  #s.public_header_files = 'HATHandyKit/**/*.h'
  s.resource_bundles = {
    'HATHandyKit' => ['HATHandyKit/**/*.{storyboard,xib,bundle}']
  }
  
  
  s.frameworks = 'UIKit', 'CoreGraphics'
  #s.library = 'xml2'
  #s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  s.dependency 'Masonry'
  s.dependency 'MJRefresh'
  s.dependency 'MBProgressHUD'
  s.dependency 'SDWebImage'
  s.dependency 'YTKNetwork'
  
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
 
 end