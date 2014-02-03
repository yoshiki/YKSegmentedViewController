Pod::Spec.new do |s|
  s.name     = 'YKSegmentedViewController'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'A segmented view controller'
  s.homepage = 'https://github.com/yoshiki/YKSegmentedViewController'
  s.authors  = { 'Yoshiki Kurihara' => 'clouder@gmail.com' }
  s.source   = { :git => 'https://github.com/yoshiki/YKSegmentedViewController.git', :tag => "1.0.0" }
  s.requires_arc = true
  s.source_files = 'YKSegmentedViewController/*.{h,m}'
  s.ios.deployment_target = '5.0'
  s.platform = :ios
end
