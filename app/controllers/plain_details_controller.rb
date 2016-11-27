class PlainDetailsController < ApplicationController
  def create
    @pl_detail = PlainDetail.new(plain_detail_params)
    @pl_detail.plain_id = params[:plain_id]
    @pl_detail.detail_id = params[:detail_id]
    if @pl_detail.save
      flash[:notice] = "新增成功"
    else
      flash[:error] = @pl_detail.errors
    end
    redirect_to edit_plain_path(params[:plain_id])
  end

  def update
    @pl_detail = PlainDetail.find(params[:pl_detail_id])
    if @pl_detail.update(plain_detail_params)
      flash[:notice] = "更新成功"
    else
      flash[:error] = @pl_detail.errors
    end
    redirect_to edit_plain_path(params[:plain_id])
  end

  def destroy
    @plain = PlainDetail.find(params[:id])
    if @plain.destroy
      flash[:notice] = "刪除成功"
    else
      flash[:error] = @plain.errors
    end
    redirect_to edit_plain_path(params[:plain_id])
  end

  private

  def plain_detail_params
    params.require(:plain_detail).permit(:plain_id, :detail_id, :screen, :coordinate)
  end
end
