class VideosController < ApplicationController
  def index
    @video = Video.new()
  end


  def upload
    @video = Video.new()
    @videos_of_plain = Video.all
  end

  def create
    @temp_video = Video.new(video_params)
    @video = Video.where(:media_file_name => @temp_video.media_file_name).first

    if @video.nil?
      @video = @temp_video
    else
      if @video.media_file_size.nil?
        @video.media_file_size = @temp_video.media_file_size
      end
      path = File.join("#{Rails.root}/public/media", @video[:media_file_name])
      logger.info("path: #{path}")
      File.open(path, "ab") { |f|
        #append chunk to file
        f.write(params[:video][:media].tempfile.read)
      }
      @video.media_file_size = File.size(path)
    end

    respond_to do |format|
      if @video.save
        flash[:notice] = "上传成功"
        format.html { redirect_to  edit_video_plain_path(@video.video_plain_id) }
        format.json { render json: {files: [@video.to_jq_upload]}, status: :created, location: @video }
      else
        flash[:error] = @video.errors
        format.html {redirect_to  edit_video_plain_path(@video.video_plain_id) }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @video = Video.find(params[:id])
      # plain_id = @video.video_plain_id
      if @video.destroy
        flash[:notice] = "删除成功"
        redirect_to  url_for(video_upload_page_path)
      elsif !plain_id
        flash[:error] = "未知错误"
        redirect_to url_for(video_upload_page_path)
      else
        flash[:error] = @video.error
        redirect_to  url_for(video_upload_page_path)
      end
    rescue Exception => e
      message = e.message
      if message =~ /empty/
        flash[:error] = "缺少档案, 上传失败"
      else
        flash[:error] = message
      end
      redirect_to url_for(video_upload_page_path)
      # redirect_to  url_for(:controller => :series, :action => :edit, :brand_id => params[:brand_id], :id => params[:series_id])
    end
  end

  def video_me
    @videos = Video.all
    p @videos
  end

  private
  def video_params
    # params.require(:video).permit(:media, :screen, :video_plain_id)
    params.require(:video).permit(:media)
  end
end
