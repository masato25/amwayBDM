class VideosController < ApplicationController
  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:notice] = "上传成功"
      redirect_to  edit_video_plain_path(@video.video_plain_id)
    else
      flash[:error] = @video.errors
      redirect_to  edit_video_plain_path(@video.video_plain_id)
    end
  end

  def destroy
    begin
      @video = Video.find(params[:id])
      plain_id = @video.video_plain_id
      if @video.destroy
        flash[:notice] = "删除成功"
        redirect_to  edit_video_plain_path(plain_id)
      elsif !plain_id
        flash[:error] = "未知错误"
        redirect_to video_plain_path
      else
        flash[:error] = @video.error
        redirect_to  edit_video_plain_path(plain_id)
      end
    rescue Exception => e
      message = e.message
      if message =~ /empty/
        flash[:error] = "缺少档案, 上传失败"
      else
        flash[:error] = message
      end
      redirect_to  url_for(:controller => :series, :action => :edit, :brand_id => params[:brand_id], :id => params[:series_id])
    end
  end

  private
  def video_params
    params.require(:video).permit(:media, :screen, :video_plain_id)
  end
end
