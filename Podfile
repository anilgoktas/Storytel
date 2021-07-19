platform :ios, "14.5"
use_frameworks!
inhibit_all_warnings!

target 'Storytel' do
  # Pods for Storytel
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'R.swift'
  pod 'SDWebImage/WebP'

  target 'StorytelTests' do
    inherit! :search_paths
    pod 'SwiftyMocky'
  end

  target 'StorytelSnapshotTests' do
    inherit! :search_paths
    pod 'SwiftyMocky'
    pod 'iOSSnapshotTestCase'
  end

end
