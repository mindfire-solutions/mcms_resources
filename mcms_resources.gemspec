$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mcms_resources/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mcms_resources"
  s.version     = "0.0.5"
  s.authors     = ["Debadatta Pradhan"]
  s.email       = ["debadattap@mindfiresolutions.com"]
  s.homepage    = "https://192.168.10.251/svn/SVNHOME/mcms/trunk/mcms_gems/mcms_resources"
  s.summary     = "McmsResources is an application for uploading images and files and magnify those images"
  s.description = "Description of McmsResources."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency "paperclip"
  s.add_dependency "will_paginate"

end

