class FeatureImagesController < ApplicationController
  before_action :check_session
  def index
    @photos = FeatureImage.order('created_at')
  end

  def new
    @photo = FeatureImage.new
  end

  def create
    @photo = FeatureImage.new(photo_params)
    @photo.detail_id = params[:detail_id]
    if @photo.save
      flash[:notice] = "上传成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      flash[:error] = "功能照片只能允许上传一张"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    end
  end

  def destroy
    @photo = FeatureImage.find(params[:id])
    if @photo.destroy
      flash[:notice] = "删除成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      flash[:error] = @photo.error
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    end
  end

  private

  def photo_params
    params.require(:feature_images).permit(:detail_id, :image)
  end
end
