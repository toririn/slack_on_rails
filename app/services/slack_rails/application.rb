class SlackRails::Application < SlackRails::Base
  include SlackRails::Module::Read
  include SlackRails::Module::Search
  include SlackRails::Module::Delete
  include SlackRails::Module::Convert
  include SlackRails::Module::Update
  include SlackRails::Module::Post
end
