class DetailImagesController < ApplicationController
  before_action :check_session
  skip_before_action :verify_authenticity_token

  def index
    @photos = DetailImage.order('created_at')
  end

  def new
    @photo = DetailImage.new
  end

  def create
    begin
      @photo = DetailImage.new(detail_image_params)
      @photo.detail_id = params[:detail_id]
      if @photo.save
        flash[:notice] = "上传成功"
        redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => params[:detail_id])
      else
        logger.error(@photo.errors) if @photo.errors.size != 0
        flash[:error] = @photo.errors
        redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => params[:detail_id])
      end
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
    @photo = DetailImage.find(params[:id])
    if @photo.destroy
      flash[:notice] = "删除成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => params[:detail_id])
    else
      flash[:error] = @photo.error
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => params[:detail_id])
    end
  end

  private

  def detail_image_params
    begin
      params.require(:detail_images).permit(:detail_id, :image)
    rescue => e
      logger.error(e)
    end
  end
end
