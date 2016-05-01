OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '225938244448347', '8456925b9a724581924fd121f6f5f045', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end