class ErrorsController < SlackAppController
  def routing
    raise ActionController::RoutingError
  end
end
