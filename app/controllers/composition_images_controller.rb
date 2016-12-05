class CompositionImagesController < ApplicationController
  before_action :check_session
  def index
    @photos = CompositionImage.order('created_at')
  end

  def new
    @photo = CompositionImage.new
  end

  def create
    @photo = CompositionImage.new(photo_params)
    @photo.detail_id = params[:detail_id]
    if @photo.save
      flash[:notice] = "照片上传成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      flash[:error] = "成份照片只能允许上传一张"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    end
  end

  def destroy
    @photo = CompositionImage.find(params[:id])
    if @photo.destroy
      flash[:notice] = "照片删除成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      flash[:error] = @photo.error
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    end
  end

  private

  def photo_params
    params.require(:composition_images).permit(:detail_id, :image)
  end
end
