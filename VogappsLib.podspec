Pod::Spec.new do |s|
  s.name             = "VogappsLib"
  s.version          = "0.5.0"
  s.summary          = "Swift lib of vogapps"
  s.description      = "Use this library to import all the swift library from vogapps"
  s.homepage         = "https://bitbucket.org/vogapps/vogappslib"
  s.license          = 'MIT'
  s.author           = { "Ogan Topkaya" => "otopkaya@me.com" }
  s.source           = { :git => "git@github.com:hpayami/vogappslib.git", :tag => s.version }

  s.platform     = :ios, '12.0'
  s.requires_arc = true
  s.source_files = 'Source/**/*'
  s.public_header_files = 'Source/**/*.h'
  s.swift_version = '5.0'
 
  s.dependency 'PureLayout', '3.1.5'
  #s.dependency 'PromiseKit', '8.1'
 #s.dependency 'PromiseKit', '6.18.1'
  s.dependency 'UICKeyChainStore', '2.1.2'
  s.dependency 'Alamofire', '5.4.4'
  s.dependency 'ObjectMapper', '4.2.0'
  s.dependency 'FBSDKLoginKit', '9.0.1'
  
end
