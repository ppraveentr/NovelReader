platform :ios, '9.0'
use_frameworks!

def local_pods_path
  { :path => '~/Documents/xCodeProject/MobileCore' }
end

target 'NovelReader' do
 #pod 'GoogleSignIn'
 #pod 'SwiftLint'
 #pod 'MobileCore', '0.0.7.2'
 pod 'MobileCore', local_pods_path
end

target 'NovelReaderTests' do
  pod 'MobileCore', local_pods_path
end
