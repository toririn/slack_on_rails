class OtacksController < SlackAppController

  def index
    set_user_list
  end

  def show
    @otacks = Otack.all
  end

  def search
    @user_name = User.convert(id: params[:user])
    @otacks = Otack.ransack(members_cont: params[:user]).result
  end

end
