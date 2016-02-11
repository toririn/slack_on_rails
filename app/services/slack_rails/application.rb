class SlackRails::Application < SlackRails::Base
  include SlackRails::Module::Read
  include SlackRails::Module::Search
  include SlackRails::Module::Delete
  include SlackRails::Module::Convert
end
