Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, SLACK_CLIENT_ID, SLACK_SECRET, scope: "search:read"
end
