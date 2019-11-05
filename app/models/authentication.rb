# class Authentication < ActiveRecord::Base
#  belongs_to :user
#  # validates :provider, :uid, :presence => true

#  def self.from_omniauth(auth)
    
    

#     if auth[:provider] == "instagram"
#         email =  auth[:info][:nickname] + '@' + 'gmail.com'    
#     end
    
#     authenticate = where(provider: auth[:provider], :uid=>auth[:uid]).first_or_initialize
#     if authenticate.user
#       authenticate.provider = auth[:provider]
#       authenticate.uid =auth[:uid]
  
#     else
#         if auth['provider'].downcase == "facebook"
#            email = auth[:email].present? ? auth[:email] :  auth[:uid].to_s+"@facebook.com"
#         elsif auth['provider'].downcase == "google"
#             email = auth[:email].present? ? auth[:email] :  auth[:uid].to_s+"@google.com"
#         end
#         user = User.find_or_initialize_by(:email => email)
#         authenticate.provider = auth[:provider]
#         authenticate.uid = auth[:uid]
#         user.email = email
#         user.save
#         authenticate.user_id = user.id
#      end
#     authenticate.save
#     authenticate.user
#  end
# end

class Authentication < ApplicationRecord
  belongs_to :user
 def self.from_omniauth(auth)
    authenticate = where(provider: auth['provider'], :uid=>auth['uid']).first_or_initialize
    register_user = User.find_by(email: auth.info.email)
    if authenticate.user
      return authenticate.user
    elsif register_user
      register_user.authentications.create(provider: auth['provider'], :uid=>auth['uid'])
      return register_user
    else
      user = User.new(
        email: auth.info.try(:email),                      
        password: Devise.friendly_token.first(8)
      )
      if user.email.blank?
        user.email=auth.extra.raw_info.id.to_s+"@gmail.com"
      end
      user.save!
      user.authentications.create(provider: auth['provider'], :uid=>auth['uid'],token: auth["credentials"]["token"])
      return user
   end
  end
end