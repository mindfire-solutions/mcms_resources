module McmsResources
  class Engine < ::Rails::Engine
  
  	  	require 'paperclip'
		require 'will_paginate'

		config.autoload_paths += %W( #{config.root}/lib )
		config.autoload_paths += Dir["#{config.root}/lib/**/"]

		require 'yaml'
		YAML::ENGINE.yamler= 'syck'
  end
end
