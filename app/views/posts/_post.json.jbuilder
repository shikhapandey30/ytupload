json.extract! post, :id, :title, :description, :v_upload, :category, :created_at, :updated_at
json.url post_url(post, format: :json)
