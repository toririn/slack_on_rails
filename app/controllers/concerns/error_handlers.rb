module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :rescue500
    rescue_from ActionController::RoutingError, with: :rescue404
  end

  private

  def rescue404(e)
    render 'errors/routing', status: 404
  end

  def rescue500(e)
    render 'errors/all', status: 500
  end
end
