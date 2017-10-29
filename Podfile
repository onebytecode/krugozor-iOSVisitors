platform :ios, '10.0'

target 'krugozor-visitorsApp' do
	use_frameworks!

	# Post installation script that enables the Swift 4 compiler's
	# legacy 3.2 mode for Swift 4-incompatible pods
	post_install do |installer|
		 incompatiblePods = ['PodA', 'PodB']

		 installer.pods_project.targets.each do |target|
				 if incompatiblePods.include? target.name
						 target.build_configurations.each do |config|
								 config.build_settings['SWIFT_VERSION'] = '3.2'
						 end
				 end
		 end
	end

	pod "QRCode"
	pod "Alamofire"
  pod 'RealmSwift'
	pod 'SwiftyBeaver'
	pod 'SwiftyJSON'
end
