class QrImagesController < ApplicationController
  def new
    @photo = QrImage.new
  end

  def create
    @photo = QrImage.new(detail_image_params)
    @photo.metadata_id = params[:p_metadatum_id]
    if @photo.save
      flash[:success] = "照片上傳成功"
      redirect_to  edit_detail_p_metadatum_path(params[:detail_id], params[:p_metadatum_id])
    else
      flash[:error] = @photo.errors
      redirect_to  edit_detail_p_metadatum_path(params[:detail_id], params[:p_metadatum_id])
    end
  end

  def destroy
    @photo = QrImage.find(params[:id])
    if @photo.destroy
      flash[:success] = "照片刪除成功"
      redirect_to  edit_detail_p_metadatum_path(params[:detail_id], params[:p_metadatum_id])
    else
      flash[:error] = @photo.error
      redirect_to  edit_detail_p_metadatum_path(params[:detail_id], params[:p_metadatum_id])
    end
  end

  private

  def detail_image_params
    params.require(:qr_image).permit(:metadata_id, :image)
  end
end
