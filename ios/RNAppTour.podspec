package = JSON.parse(File.read("../package.json"))
version = package['version']

Pod::Spec.new do |s|
  s.name         = "RNAppTour"
  s.version      = version
  s.summary      = package["description"]
  s.homepage     = "n/a"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/author/RNAppTour.git", :tag => "master" }
  s.source_files  = "RNAppTour/**/*.{h,m}"
  s.requires_arc = true
  s.static_framework = true

  s.dependency "React"

end

  