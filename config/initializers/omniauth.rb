OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
  provider :facebook, '624531117593461', '3fa162a12dc8683dd73b1d1d0a0c9c00' if Rails.env.development?
  provider :facebook, '483309578450134', '053a7c02ff2bdb34433b85fb9a4ca6d2' if Rails.env.production?
end

require "omniauth"
