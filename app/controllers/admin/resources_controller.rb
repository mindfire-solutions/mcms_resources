=begin
	@Name: Admin Resources controller
	@Use:  Creating , modifying, deleting resources for the cms
	@Created date: 24-07-2012
	@Modified Date: 24-07-2012
  @Company:  Mindfire Solutions
=end
class Admin::ResourcesController < ApplicationController
  
  #before_filter :authenticate_user!
  prepend_before_filter :authenticate_user!

  #load_and_authorize_resource :class => false
  load_and_authorize_resource

  #Assigning a layout admin for admin side controller
  layout '/mcms/main_layout'

  # GET /admin/images
  # This is a default method for listing all assets for mcms_resources
  def index

    #checking params type whether file or image and the perticaular file types will be sorted
    @type = params[:type]

    if @type == 'image'
      @resources = Resource.all_images.paginate({
        :page => params[:page],
        :per_page => resource_per_page
      })
    elsif @type == 'file'
      @resources = Resource.all_files.paginate({
        :page => params[:page],
        :per_page => resource_per_page
      })
    else
      @resources = Resource.paginate({
        :page => params[:page],
        :per_page => resource_per_page
      })
    end

    respond_to do |format|
      format.html{}
    end
  end

  # GET /admin/images/1
  # This is a method for showing an image
  def show
    @resource = Resource.find(params[:id]) || not_found

    respond_to do |format|
      format.html{}
    end

  end

  # GET /admin/images/new
  # This is method for opening form for uploading a resource
  # Checks the type of resource needs to be uploaded and open the file field
  def new
    @resource = Resource.new
    @type = 'file' if params[:type] == 'file'
    respond_to do |format|
      format.html{}
    end
  end

  # GET /admin/images/1/edit
  #This method opens the edit form for file upload
  def edit

    @resource = Resource.find(params[:id])
    @resource.type = 'Resource'
    @type = 'file' if params[:type] == 'file'

  end

  # POST /admin/images
  # This method creates file record and upload resources to the local server
  def create
    @resource = Resource.new(params[:resource])

    @resource.assetable_id = 1
    @resource.assetable_type = 'User'

    if params[:resource]
      if image_types.include? params[:resource][:data].content_type
        @resource.type = 'Ckeditor::Picture'
      else
        @resource.type = 'Ckeditor::AttachmentFile'
      end
    end

    respond_to do |format|
      
      if @resource.save
        
        #Checking resource type for image or file and redirecting as per the lists with conditions
        if @resource.is_type_image?        
          redirect_path = admin_resources_path(:type => 'image')
        else
          redirect_path = admin_resources_path(:type => 'file')
        end

        format.html { redirect_to redirect_path, notice: 'Resource was successfully uploaded.' }
      else
        format.html { render action: "new", :type => @type }
      end
    end
  end

  # PUT /admin/resources/1
  # This method updates file record and upload resources to the local server
  def update
    @resource = Resource.find(params[:id])

    @resource.assetable_id = 1
    @resource.assetable_type = 'User'

    if image_types.include? params[:resource][:data].content_type
      @resource.type = 'Ckeditor::Picture'
    else
      @resource.type = 'Ckeditor::AttachmentFile'
    end

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to admin_resources_path, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /admin/images/1
  # This method destroys file records
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to admin_resources_url }
      format.json { head :no_content }
    end
  end

protected                  #protected methods start here

  #Defining a not_found method for avoiding error raise
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  #defining number of resource records per page to display
  #maximum upto 10 records per page .
  def resource_per_page
    10
  end

  #Initializing image types array
  #Images can only contain jpeg, png, gif, tif file formats
  def image_types
    ["image/jpeg", "image/png", "image/jpg", "image/gif", "image/tif"]
  end

end

