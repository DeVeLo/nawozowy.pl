class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def welcome
    if current_user
      redirect_to instytucja_rolnicy_path(instytucja_id: current_user.instytucja_id)
    else
      redirect_to new_user_session_path
    end
  end
end
