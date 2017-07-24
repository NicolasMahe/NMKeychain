Pod::Spec.new do |s|
  s.name             = 'NMKeychain'
  s.version          = '0.0.1'
  s.summary          = 'Save data in Keychain with ease'
  s.description      = <<-DESC
Save data in Keychain with ease. Typed, notification and in memory.
                       DESC

  s.homepage         = 'https://github.com/NicolasMahe/NMKeychain'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nicolas Mahé' => 'nicolas@mahe.me' }
  s.source           = { :git => 'https://github.com/NicolasMahe/NMKeychain.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'NMKeychain/**/*.swift'

  s.frameworks = 'UIKit'

  s.dependency 'KeychainAccess'
end
