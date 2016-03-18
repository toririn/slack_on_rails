class TodoManagement
  include ActiveModel::Model
  include TodoManagementDecorator

  attr_accessor(
    :api_token,
    :query,
    :ts,
    :selected_day,
  )

  def search
    slack = SlackRails::Application.new(api_token)
    @results = slack.search_by_query_for_chat(query, Constants::TodoManagements::SEARCH_MAX_COUNT )
    self
  end
end
