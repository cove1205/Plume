Pod::Spec.new do |s|

  s.name         = "Plume"
  s.version      = "0.1.0"
  s.summary      = "a library that encapsulation for Alamofire written by Swift."

  s.description  = <<-DESC
        
                Plume is a library that encapsulation for Alamofire written by swift
        
                   DESC

  s.homepage     = "https://github.com/ganquan881205/Plume"
  # s.screenshots  = "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/logo.png"
  # s.social_media_url   = "https://github.com/onevcat"
  
  
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { 'Cove' => 'ganquan007fox@gmail.com' }

  s.swift_versions = ['5.1']
  
  s.dependency 'Alamofire', '~> 5.4'

  s.ios.deployment_target = "12.0"
  s.source = { :git => 'https://github.com/ganquan881205/Plume.git', :tag => s.version.to_s }
  s.source_files  = ["Sources/**/*.swift"]

end

