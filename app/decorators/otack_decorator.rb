module OtackDecorator
  def render_members
    split_members.map do |member|
     member_name = User.convert(id: member)
     member_image = UserImage.eager_find_path(member)
     "<div style=\"margin-padding: 10px;\" ><img src=\"#{member_image}\" \\><span>#{member_name}</span></div>"
     #render(partial: "otack_channel", locals: member)
    end.join("<br>").html_safe
  end

  def introduction
    @@otack_channels ||= Channel.otack_channels.pluck(:id, :introduction)
    @@otack_channels.find{|channel_id, intro| channel_id == id }.try(:[], 1).presence || Constants::Channels::Errors::NOT_INTRODUCTION
  end

  private

  def split_members
    members.split(",")
  end
end
