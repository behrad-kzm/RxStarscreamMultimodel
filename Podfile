# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
def rx_swift
  pod 'RxSwift', '~> 4.0'
end

def rx_cocoa
  pod 'RxCocoa', '~> 4.0'
end
target 'RxTestLab' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_swift
  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'RxStarscream'
  # Pods for RxTestLab

  target 'RxTestLabTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RxTestLabUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
