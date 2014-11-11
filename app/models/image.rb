class Image < ActiveRecord::Base
	#validates_format_of :type,
    #with: /image/,
	#message: "must be a picture"
	#validates :data
	belongs_to :user

	def uploaded_picture=(picture_field)
	  if picture_field	
		self.name = picture_field.original_filename
		self.type1 = picture_field.content_type.chomp
		self.data = picture_field.read
	  end
	end
end
