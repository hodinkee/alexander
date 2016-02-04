Pod::Spec.new do |spec|
  spec.name         = 'Alexander'
  spec.version      = '3.0.0'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/hodinkee/alexander'
  spec.authors      = { 'Caleb Davenport' => 'caleb@calebd.me', 'Jonathan Baker' => 'jonathan@jonathanbaker.me' }
  spec.summary      = 'An extremely simple JSON helper written in Swift.'
  spec.source       = { :git => 'https://github.com/hodinkee/alexander.git', :tag => "v#{spec.version}" }
  spec.source_files = 'Alexander/*.{swift}'
  spec.framework    = 'Foundation'
  spec.requires_arc = true

  spec.ios.deployment_target = '8.0'
  spec.watchos.deployment_target = '2.0'
  spec.osx.deployment_target = '10.9'
  spec.tvos.deployment_target = '9.0'
end
