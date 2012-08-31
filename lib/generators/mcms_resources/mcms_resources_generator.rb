=begin

  @File Name                            : mcms_resources_generator.rb
	@Company Name                         : Mindfire Solutions Pvt. Ltd.
	@Date Created                         : 01-08-2012
  @Date Modified                        : 01-08-2012
  @Last Modification Details            :
  @Purpose                              : This file is responsible to install assets and views for mcms_resources module in other application/module

=end
class McmsResourcesGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
	  # @Params     : None
	  # @Returns    : None
	  # @Purpose    : To Copy all the migrations from db/migrate of engine to db/migrate of application
	  def add_migrations

		say "copying migrations......."

		# running command line command to copy engine's migration file
		rake("mcms_resources_engine:install:migrations")

	  end # end method
end
