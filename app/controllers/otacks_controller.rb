class OtacksController < SlackAppController

  def index
    @otacks = Otack.all
  end

  def show
    set_user_list
  end

  def search
    @user_name = User.convert(id: params[:user])
    @otacks = Otack.ransack(members_cont: params[:user]).result
  end

end
