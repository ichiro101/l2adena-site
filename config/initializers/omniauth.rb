Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 'TEST', 'ANOTHER_TEST'
end
