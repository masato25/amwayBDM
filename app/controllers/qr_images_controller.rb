class QrImagesController < ApplicationController
  before_action :check_session
  def new
    @photo = QrImage.new
  end

  def create
    @photo = QrImage.new(detail_image_params)
    @photo.detail_id = params[:detail_id]
    if @photo.save
      flash[:notice] = "上传成功"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      flash[:error] = @photo.errors
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    end
  end

  def destroy
    @photo = QrImage.find(params[:id])
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
    params.require(:qr_images).permit(:detail_id, :image)
  end
end
