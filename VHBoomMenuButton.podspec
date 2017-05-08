Pod::Spec.new do |s|
  s.name             = 'VHBoomMenuButton'
  s.version          = '2.0.0'
  s.summary          = 'A menu which can ... BOOM!'
  s.description      = <<-DESC
                       This is a menu-button whose sub buttons will boom to show.
                         DESC
  s.homepage         = 'https://github.com/Nightonke/VHBoomMenuButton'
  s.license          = 'MIT'
  s.author           = { 'Nightonke' => "2584541288@qq.com" } 
  s.source           = { :git => 'https://github.com/Nightonke/VHBoomMenuButton.git', :tag => '2.0.0' }
  s.platform         = :ios, '8.0'
  s.requires_arc     = true
  
  s.default_subspec = 'ObjC'
  
  s.subspec 'ObjC' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files = 'VHBoomMenuButton/**/*.{h,m,swift}' 
  end

  s.subspec 'Swift' do |ss|
    ss.ios.deployment_target = '8.0'
    ss.source_files = 'VHBoomMenuButtonSwift/**/*.{h,m,swift}'
    ss.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }
  end
  
end