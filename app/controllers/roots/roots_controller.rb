class RootsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to tops_url if verify_session?
  end
end
