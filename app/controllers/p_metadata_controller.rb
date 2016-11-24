class PMetadataController < ApplicationController

  def index
    detail_id = params[:detail_id]
    @p_metadata = PMetadata.where("detail_id = #{detail_id}")
  end

  def new
    @p_metadata = PMetadata.new
  end

  def create
    @p_metadata = PMetadata.new(meta_params)
    @p_metadata.detail_id = params[:detail_id]
    if @p_metadata.valid?
      @p_metadata.save
      flash[:success] = "品牌新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @p_metadata.errors
      redirect_to new_detail_path
    end
  end

  def edit
    @qr_image = QrImage.new
    @p_metadata = PMetadata.find(params[:id])
    @qimage = QrImage.where("metadata_id = #{params[:id]}").first
    p @qimage.methods
  end

  private

  def meta_params
    params.require(:p_metadata).permit(:SN, :Volume, :Price, :Color)
  end
end
