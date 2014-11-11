	module PhotoSend
		extend ActiveSupport::Concern
		def picture

			send_data(self.data,
				filename: self.name,
				type: self.type1,
				disposition: "inline")
		end
	end