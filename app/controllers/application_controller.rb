class ApplicationController < ActionController::Base
  helper_method :current_user_id, :logged_in?

  private

  def authenticate_user!
    unless logged_in?
      redirect_to login_path, alert: "Você precisa fazer login para acessar essa página."
    end
  end

  def current_user_id
    session[:user_id]
  end

  def logged_in?
    current_user_id.present?
  end
end