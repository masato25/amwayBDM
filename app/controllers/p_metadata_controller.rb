class PMetadataController < ApplicationController
  before_action :check_session
  skip_before_action :verify_authenticity_token
  def index
    check_mysession
    detail_id = params[:detail_id]
    @p_metadata = PMetadata.where("detail_id = #{detail_id}")
  end

  def new
    @p_metadata = PMetadata.new
  end

  def create
    @p_metadata = PMetadata.new(meta_params)
    if PMetadata.where("detail_id = #{params[:detail_id]}").size >= 5
      flash[:error] = "商品清单只允许5笔,超过上限"
      redirect_to action: "index"
    else
      @p_metadata.detail_id = params[:detail_id]
      if @p_metadata.valid?
        @p_metadata.save
        flash[:notice] = "新增成功"
        redirect_to action: "index"
      else
        flash[:error] = @p_metadata.errors
        redirect_to new_detail_path
      end
    end

  end

  def destroy
    @p_metadata = PMetadata.find(params[:id])
    if @p_metadata.destroy
      flash[:notice] = "删除成功"
    else
      flash[:error] = @p_metadata.errors
    end
    redirect_to action: "index"
  end

  def edit
    check_mysession
    @p_metadata = PMetadata.find(params[:id])
  end

  def update
    @p_metadata = PMetadata.find(params[:id])
    if @p_metadata.update(meta_params)
      flash[:notice] = "更新成功"
    else
      flash[:error] = @p_metadata.errors
    end
    redirect_to action: "edit"
  end

  private

  def meta_params
    params.require(:p_metadata).permit(:SN, :Volume, :Price, :Color)
  end
end
