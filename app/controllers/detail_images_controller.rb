class DetailImagesController < ApplicationController
  before_action :check_session
  def index
    @photos = DetailImage.order('created_at')
  end

  def new
    @photo = DetailImage.new
  end

  def create
    @photo = DetailImage.new(detail_image_params)
    @photo.detail_id = params[:detail_id]
    if @photo.save
      flash[:notice] = "照片上傳成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      flash[:error] = @photo.errors
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    end
  end

  def destroy
    @photo = DetailImage.find(params[:id])
    if @photo.destroy
      flash[:notice] = "照片刪除成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      flash[:error] = @photo.error
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    end
  end

  private

  def detail_image_params
    params.require(:detail_images).permit(:detail_id, :image)
  end
end
