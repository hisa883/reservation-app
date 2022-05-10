require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "c98c972bd32941b692523e6c51afc225", "003441f078c3464897e59c5ec9aeaa99", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end

OmniAuth.config.allowed_request_methods = [:post, :get]