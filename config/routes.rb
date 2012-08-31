=begin

  @File Name                 : routes.rb
  @Company Name              : Mindfire Solutions Private Limited
  @Date Created              : 01-08-2012
  @Date Modified             : 01-08-2012
  @Last Modification Details :
  @Purpose                   : To redirect the pages throughout the application.

=end
Rails.application.routes.draw do
	namespace :admin, :path => 'mcms' do
	  	#root :to => 'images#index'
	  	resources :resources do
      		match 'resources/new/:type', :to => 'resources#new'
    	end
	end
end
