Pod::Spec.new do |s|
s.name        = 'LottieViewMager'
s.version     = '0.0.1'
s.authors     = { 'MrLujh' => '287929070@qq.com' }
s.homepage    = 'https://github.com/MrLujh/LottieViewMager'
s.summary     = 'LottieViewMager'
s.source      = { :git => 'https://github.com/MrLujh/LottieViewMager.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }
s.platform = :ios, '8.0'
s.requires_arc = true

s.source_files = 'LottieViewMager/**/*.{h,m}'
s.ios.deployment_target = '7.0'
s.dependency 'lottie-ios'
end