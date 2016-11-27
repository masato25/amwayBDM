class QrImagesController < ApplicationController
  before_action :check_session
  def new
    @photo = QrImage.new
  end

  def create
    @photo = QrImage.new(detail_image_params)
    @photo.p_metadata_id = params[:p_metadata_id]
    if @photo.save
      flash[:notice] = "照片上傳成功"
      redirect_to  edit_detail_p_metadata_path(params[:detail_id], params[:p_metadata_id])
    else
      flash[:error] = @photo.errors
      redirect_to  edit_detail_p_metadata_path(params[:detail_id], params[:p_metadata_id])
    end
  end

  def destroy
    @photo = QrImage.find(params[:id])
    if @photo.destroy
      flash[:notice] = "照片刪除成功"
      redirect_to  edit_detail_p_metadata_path(params[:detail_id], params[:p_metadata_id])
    else
      flash[:error] = @photo.error
      redirect_to  edit_detail_p_metadata_path(params[:detail_id], params[:p_metadata_id])
    end
  end

  private

  def detail_image_params
    params.require(:qr_image).permit(:p_metadata_id, :image)
  end
end
