#
# Be sure to run `pod lib lint IDIAZM.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'IDIAZM'
  s.version               = '0.0.3'
  s.summary               = 'This is a test CocoaPods Library for iOS Swift.'
  s.homepage              = 'https://github.com/ivandiazmolina/IDIAZM-library'
  s.license               = 'MIT'
  s.author                = { 'ivandiazmolina' => 'ivandiazmolina92@gmail.com' }
  s.source                = { :git => 'https://github.com/ivandiazmolina/IDIAZM-library.git', :tag => s.version.to_s }
  s.swift_versions        = ['5.0']
  s.ios.deployment_target = '11.0'
  s.source_files          = 'Source/**/*.{swift,xib}'
  #s.resource 		 = 'Source/Views/*.xib'
  #s.resource_bundles 	 = { 'IDIAZM' => [ 'Pod/Source/**/*.xib' ] }
end
