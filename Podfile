# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'Pokemon' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pokemon
  pod 'MaterialComponents/Snackbar'
  pod 'SwiftyJSON'
  pod 'IQKeyboardManagerSwift'
  pod 'Moya'
  pod 'SDWebImage'
  
  target "Pokedex" do
     project 'Pokedex/Pokedex.xcodeproj'
     workspace 'Pokemon.xcworkspace'
  end
  
  target 'PokemonTests' do
    inherit! :search_paths
    
    # Pods for testing
  end

  target 'PokemonUITests' do
    # Pods for testing
  end
  

end
