class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_session
    @session = cookies[:msession] == ENV["api_key"]
  end

end
