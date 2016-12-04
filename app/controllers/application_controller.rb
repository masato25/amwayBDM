class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_session
    @session = cookies[:msession] == ENV["api_key"]
  end

  def check_mysession
    if @session != true
      flash[:error] = "尚未登入 請登入"
      redirect_to root_path
    end
  end

end
