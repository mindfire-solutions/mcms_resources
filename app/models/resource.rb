=begin
	@Name: Admin Resource model
	@Use:  Creating , modifying, deleting images and files for the cms
	@Created date: 24-07-2012
	@Modified Date: 24-07-2012
  @Company:  Mindfire Solutions
=end
class Resource < ActiveRecord::Base

  #Redefining the table name for the Image model as mcms_assets
  self.table_name = 'mcms_assets'

  #Defining has_attached_file as association and some paperclip extensions
  has_attached_file :data,
  :styles => lambda{ |a| ["image/jpeg", "image/png", "image/jpg", "image/gif"].include?( a.content_type ) ? { :thumb => '60x60', :small => '110x110>', :medium => '225x255>', :content => '450x450>'} : {}  },
  :url  => lambda{ |a| ["image/jpeg", "image/png", "image/jpg", "image/gif"].include?( a.content_type ) ? "/ckeditor_assets/pictures/:id/:style_:basename.:extension" : "/ckeditor_assets/attachments/:id/:filename" },
  :path  => lambda{ |a| ["image/jpeg", "image/png", "image/jpg", "image/gif"].include?( a.content_type ) ? ":rails_root/public/ckeditor_assets/pictures/:id/:style_:basename.:extension" : ":rails_root/public/ckeditor_assets/attachments/:id/:filename" }


  #Including  validations for images as size, content_type, etc
  #validates :data, :presence => true
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 5.megabytes

  #Writing attribute accessibles
  attr_accessible :data, :data_file_name, :data_content_type, :data_file_size

  #Writing scope for a definite case of searching records
  scope :all_images, lambda { where("data_content_type LIKE"+" 'image%'") }
  scope :all_files, lambda { where("data_content_type NOT LIKE"+" 'image%'" ) }

  #after_post_process :save_image_dimensions

  #Checking for a image type file
  def is_type_image?
    image_types.include? self.data_content_type
  end

  protected     #protected methods start here

  #Saving image dimensions
  def save_image_dimensions
    if data.content_type == "image/jpeg" || "image/png" || "image/jpg" || "image/gif"
    geo = Paperclip::Geometry.from_file(data.queued_for_write[:original])
    self.width = geo.width
    self.height = geo.height
    end
  end

  #Initializing image types array
  #Can only contain jpeg, png, gif, jpg and tif file formats
  def image_types
    ["image/jpeg", "image/png", "image/jpg", "image/gif", "image/tif"]
  end


end

