
Pod::Spec.new do |s|
s.name             = 'WBNetworkingLite'
s.version          = '1.0.0'
s.summary          = 'WBNetworkingLite-基于NSURLSession的轻量级网络库'
s.homepage         = 'https://github.com/wans3112/LYNetworking'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'MRCaoHH' => 'wanslm@foxmail.com' }
s.source           = { :git => 'https://github.com/wans3112/WBNetworkingLite.git', :tag => s.version.to_s }
s.ios.deployment_target = '8.0'
s.source_files     = 'WBNetworkingLite/Classes/**/*'

s.dependency 'Reachability'

end
