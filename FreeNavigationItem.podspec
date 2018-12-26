Pod::Spec.new do |s|
  s.name         = "FreeNavigationItem"
  s.version      = "0.0.1"
  s.summary      = "Set free UIBarButtonItems"
  s.homepage     = "https://github.com/Natai/FreeNavigationItem"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "natai" => "" }
  s.platform     = :ios, "11.0"
  s.swift_version = "4.2"
  s.source       = { :git => "https://github.com/Natai/FreeNavigationItem.git", :tag => "#{s.version}" }
  s.source_files = "Source/*.swift"
end
