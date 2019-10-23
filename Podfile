platform :ios, '9.0'
use_frameworks!

def local_pods_path
  { :git => 'https://github.com/ppraveentr/MobileCore.git', :tag => '0.0.8.0' }
end

target 'NovelReader' do
 pod 'SwiftLint'
 pod 'MobileCore', local_pods_path
end

target 'NovelReaderTests' do
  pod 'MobileCore', local_pods_path
end
