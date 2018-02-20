Pod::Spec.new do |s|

    # From https://www.raywenderlich.com/99386/create-cocoapod-swift

    # Basic Infos
    s.platform = :ios
    s.ios.deployment_target = '8.0'
    s.name = "RBGraphics"
    s.summary = "RBGraphics contains Custom graphics elements."
    s.requires_arc = true

    # Semantic Versionning - major.minor.patch
    s.version = "0.1.0"

    # License Type
    s.license = { :type => "MIT", :file => "LICENSE" }

    # Myself
    s.author = { "Romuald Brochard" => "romuald.brochard@gmail.com" }

    # Home & sources
    s.homepage = "https://github.com/Olympiloutre/RBGraphics"
    s.source = { :git => "https://github.com/Olympiloutre/RBGraphics.git", :tag => "#{s.version}"}

    # Framework and Dependencies
    s.framework = "UIKit"
    s.framework = "Foundation"

    # Public sources file
    s.source_files = "RBGraphics/**/*.{swift}"

    # Resources
    s.resources = "RBGraphics/**/*.{png,jpeg,jpg,storyboard,xib}"
end
