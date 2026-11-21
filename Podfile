platform :ios, '13.0'

target 'KoreanTimeBlocker' do
  use_frameworks!

  pod 'GoogleMaps'
  pod 'GooglePlaces'
end

# The pod versions pinned in Podfile.lock declare old deployment targets,
# which recent Xcode versions refuse to build. Raise them to iOS 12.
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end
