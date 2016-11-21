class DetailsController < ApplicationController
  def index
    @details = Detail.order('created_at')
  end

  def new
    @detail = Detail.new
  end

  def create
    @detail = Detail.new(detail_params)
    if @detail.valid?
      @detail.save
      flash[:success] = "品牌新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @detail.errors
      redirect_to new_detail_path
    end
  end

  private

  def detail_params
    params.require(:brand).permit(:BrandName, :Feature, :HealthyFeature, :HealthyTip, :SNColor)
  end
end
