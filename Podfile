# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TechMartFinal' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          config.build_settings.delete('CODE_SIGNING_ALLOWED')
          config.build_settings.delete('CODE_SIGNING_REQUIRED')
      end
  end  # Pods for TechMartFinal
	# Core
  pod 'ObjectMapper', '~> 3.2'
  pod 'Reusable', '~> 4.0'
  pod 'Then', '~> 2.3'
  pod 'MJRefresh', '~> 3.1'
  pod 'OrderedSet', '3.0'
  pod 'Validator', '~> 3.0.2'
  pod 'FSPagerView'
  pod 'StatusBarNotifications'
  pod 'Localize-Swift'
  pod 'IQKeyboardManagerSwift’
  pod 'TextFieldEffects'
  pod 'FSPagerView', '~> 0.7.0'

  # Rx
  pod 'RxSwift', '~> 4.1'
  pod 'RxCocoa', '~> 4.1'
  pod 'NSObject+Rx', '~> 4.3'
  pod 'RxDataSources', '~> 3.0'
  pod 'RxAlamofire', '~> 4.2'
  pod 'RxGesture'
  
  #
  pod 'MBProgressHUD'
  pod 'SDWebImage', '~> 4.4'
  pod 'ActionSheetPicker-3.0', '~> 2.3'

end
