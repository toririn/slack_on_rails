module TodoManagementsCallback
  extend ActiveSupport::Concern

  included do
    before_action :set_channel_name_param, only: [:index, :show, :update]
    before_action :set_selected_day_param
    before_action :set_todo_management_param, only: [:index,:show, :update]
  end
end
