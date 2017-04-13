class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_session
    ss = false
    if ENV["skip_token"] != "false"
      ss = true
    else
      if cookies.key?("msession")
        logger.info("cc2")
        ss = cookies["msession"] == ENV["api_key"]
      end
    end
    @session = ss
    return @session
  end

  def check_mysession
    if !@session
      flash[:error] = "尚未登入 请登入"
      redirect_to root_url
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
