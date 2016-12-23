class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_session
    if ENV["skip_token"]
      @session = true
      return @session
    end
    @session = cookies[:msession] == ENV["api_key"]
  end

  def check_mysession
    if @session != true
      flash[:error] = "尚未登入 请登入"
      redirect_to root_path
    end
  end

end


require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
