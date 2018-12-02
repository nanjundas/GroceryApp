platform :ios, '10.0'
use_frameworks!

workspace 'GroceryApp'

project './GroceryAppCore/GroceryAppCore.xcodeproj'
project './GroceryApp/GroceryApp.xcodeproj'

target 'GroceryAppCore' do

    pod 'IGListKit'
    pod 'RealmSwift'
    
    project './GroceryAppCore/GroceryAppCore.xcodeproj'

end

target 'GroceryApp' do

    pod 'IGListKit'
    pod 'RealmSwift'

    project './GroceryApp/GroceryApp.xcodeproj'
    
end