class Post < ApplicationRecord
	mount_uploader :v_upload, VideoUploader
end
