class ContentImagesController < ApplicationController
  before_action :check_session
  def index
    @photos = ContentImage.order('created_at')
  end

  def new
    @photo = ContentImage.new
  end

  def create
    begin
      @photo = ContentImage.new(detail_image_params)
      @photo.detail_id = params[:detail_id]
      if @photo.save
        flash[:notice] = "上传成功"
        redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
      else
        logger.error(@photo.errors) if @photo.errors.size != 0
        flash[:error] = "上传失败,档案可能已经存在, 只允许上传一张药丸图"
        redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
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

  def destroy
    @photo = ContentImage.find(params[:id])
    if @photo.destroy
      flash[:notice] = "删除成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      flash[:error] = @photo.error
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    end
  end

  private

  def detail_image_params
    begin
      params.require(:content_images).permit(:detail_id, :image)
    rescue
    end
  end
end
