class TopsController < SlackAppController

  def index
    @user_name = session[:user][:name]
    @eyes_chats = slack.search_by_reaction_for_chat(user_id: session[:user][:id], reaction_type: Constants::SlackRails::SlackReactions::EYES)
  end
end
