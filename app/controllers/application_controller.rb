class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_current_user

  private

  def load_current_user
    @current_user=User.where(id: session[:user_id]).take
  end

  def check_auth
    unless @current_user
      redirect_to login_path, danger: "Доступ без авторизации запрещен"
    end
  end

  def check_admin
    unless @current_user.try(:admin?)
      flash[:danger]="Доступ запрещен"
      begin
        redirect_to :back
      rescue
        redirect_to root_path
      end
    end
  end
end
