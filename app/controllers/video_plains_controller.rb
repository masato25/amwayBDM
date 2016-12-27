class VideoPlainsController < ApplicationController
  before_action :check_session

  def index
    check_mysession
    @vd_palins = VideoPlain.order('created_at')
  end

  def new
    @plain = VideoPlain.new
  end

  def create
    @plain = VideoPlain.new(video_plain_params)
    if @plain.valid?
      @plain.save
      flash[:success] = "新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @plain.errors
      redirect_to new_plain_path
    end
  end

  def edit
    check_mysession
    @plain = VideoPlain.find(params[:id])
    @video = Video.new()
    default_nscreen = 3
    if ENV["number_of_screen"] =~ /^\d+$/
      default_nscreen = ENV["number_of_screen"].to_i
    end
    @number_of_screen = (1..default_nscreen).to_a
    @videos_s1 = Video.where("video_plain_id = #{params[:id]} and screen = 1")
    @videos_s2 = Video.where("video_plain_id = #{params[:id]} and screen = 2")
    @videos_s3 = Video.where("video_plain_id = #{params[:id]} and screen = 3")
  end

  def destroy
    @plain = VideoPlain.find(params[:id])
    if @plain.destroy
      Video.where("video_plain_id = #{params[:id]}").destroy_all
      Machine.where("video_plain_id = #{params[:id]}").update_all("video_plain_id = 0")
    end
    redirect_to action: "index"
  end

  private
  def video_plain_params
    params.require(:video_plain).permit(:name)
  end
end
