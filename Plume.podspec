Pod::Spec.new do |s|

  s.name         = "Plume"
  s.version      = "0.1.0"
  s.summary      = "a library that encapsulation for Alamofire written by Swift."
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { 'Cove' => 'ganquan007fox@foxmail.com' }
  s.readme       =  "https://github.com/cove1205/Plume/README.md"
  s.description  = <<-DESC
                Plume is a library that encapsulation for Alamofire written by swift
                   DESC

  s.homepage     = "https://github.com/cove1205/Plume"
  # s.screenshots  = "https://raw.githubusercontent.com/cove1205/Plume/master/images/logo.png"
  # s.social_media_url   = "https://github.com/cove1205"
  
  s.swift_versions = ['5.1']
  s.dependency 'Alamofire', '~> 5.4'
  s.ios.deployment_target = "12.0"
  s.source = { :git => 'https://github.com/cove1205/Plume.git', :tag => s.version.to_s }
  s.source_files  = ["Sources/**/*.swift"]

end

