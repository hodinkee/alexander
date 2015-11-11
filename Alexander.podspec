Pod::Spec.new do |spec|
  spec.name         = 'Alexander'
  spec.version      = '1.5'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/hodinkee/alexander'
  spec.authors      =  { 'Caleb Davenport' => 'calebmdavenport@gmail.com' }
  spec.summary      = 'Alexander is an extremely simple JSON helper written in Swift. It brings type safety and Foundation helpers to the cumbersome task of JSON unpacking.'
  spec.source       =   { :git => 'https://github.com/hodinkee/alexander.git', :tag => "#{spec.version}" }
  spec.source_files = '*.{swift}'
  spec.framework    = 'Foundation'
  spec.requires_arc = true
  spec.social_media_url = 'https://twitter.com/calebd'

  spec.ios.deployment_target = '8.0'
  spec.watchos.deployment_target = '2.0'
  spec.osx.deployment_target = '10.9'
  spec.tvos.deployment_target = '9.0'
end