Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, Constants::SLACK_CLIENT_ID, Constants::SLACK_SECRET, scope: "identify,read,post", request_path: "/#{Constants::ROOT_PATH}auth/slack", callback_path: "/#{Constants::ROOT_PATH}auth/slack/callback"
end
