# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SampleProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SampleProject
  pod 'Alamofire', '~> 5.2.1'
  pod 'Kingfisher', '~> 5.0'
  pod 'BRYXBanner', '~> 0.8.0'
  pod 'PromiseKit', '~> 6.13.1'
  pod 'IQKeyboardManagerSwift'
  pod 'SVPinView', '~> 1.0'
  pod 'AdvancedPageControl'
 # pod 'Floaty', '~> 4.1.0'
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FacebookShare'
  pod 'SwiftyContacts'
  pod 'Lightbox'
  pod 'PryntTrimmerView', '~> 4.0.2'
  pod 'SteviaLayout', '~> 5.1.2'


 # pod 'Toast-Swift', '~> 5.0.0'



end
post_install do |installer|
  installer.generated_projects.each do |project|
      project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
              config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
           end
      end
  end
end
