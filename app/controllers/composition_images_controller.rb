class CompositionImagesController < ApplicationController
  before_action :check_session
  skip_before_action :verify_authenticity_token
  def index
    @photos = CompositionImage.order('created_at')
  end

  def new
    @photo = CompositionImage.new
  end

  def create
    begin
      @photo = CompositionImage.new(photo_params)
      @photo.detail_id = params[:detail_id]
      if @photo.save
        flash[:notice] = "照片上传成功"

      else
        logger.error(@photo.errors.to_s) if @photo.errors.size != 0
        flash[:error] = "上传失败,档案可能已经存在, 只允许一张其他图片"
      end
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => params[:detail_id])
    rescue Exception => e
      message = e.message
      if message =~ /empty/
        flash[:error] = "缺少档案, 上传失败"
      else
        flash[:error] = message
      end
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => params[:detail_id])
    end
  end

  def destroy
    @photo = CompositionImage.find(params[:id])
    if @photo.destroy
      flash[:notice] = "照片删除成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => params[:detail_id])
    else
      flash[:error] = @photo.error
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => params[:detail_id])
    end
  end

  private

  def photo_params
    begin
      params.require(:composition_images).permit(:detail_id, :image)
    rescue => e
      logger.error(e)
    end
  end
end
