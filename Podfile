platform :ios, '10.0'
use_frameworks!

workspace 'GroceryApp'

project './GroceryAppCore/GroceryAppCore.xcodeproj'
project './GroceryApp/GroceryApp.xcodeproj'

target 'GroceryAppCore' do

    pod 'IGListKit'
    pod 'RealmSwift'
    
    project './GroceryAppCore/GroceryAppCore.xcodeproj'

    target 'GroceryAppCoreTests' do
        inherit! :search_paths
        # Pods for testing
    end

end

target 'GroceryApp' do

    pod 'IGListKit'
    pod 'RealmSwift'

    project './GroceryApp/GroceryApp.xcodeproj'
    
    target 'GroceryAppTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
    target 'GroceryAppUITests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end
