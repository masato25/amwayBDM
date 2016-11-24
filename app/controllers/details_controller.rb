class DetailsController < ApplicationController
  before_action :check_detail_existing, only: [:edit, :image_upload]

  def index
    @details = Detail.joins(:series)

    respond_to do |format|
      format.html
      format.json {
        render :json => @details.to_json
      }
    end
  end

  def new
    @detail = Detail.new
  end

  def create
    @detail = Detail.new(detail_params)
    @detail.series_id = params["series_id"]
    if @detail.valid?
      @detail.save
      flash[:success] = "品牌新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @detail.errors
      redirect_to new_detail_path
    end
  end

  def edit
    @detail = Detail.find(params[:id])
  end

  def image_upload
    @id = params[:detail_id]
    @photo = DetailImage.new()
    @dphoto = DetailImage.where("detail_id = #{params[:detail_id]}")
    @fphoto = FeatureImage.where("detail_id = #{params[:detail_id]}").first
    @cphoto = CompositionImage.where("detail_id = #{params[:detail_id]}").first
  end

  private

  def detail_params
    params.require(:detail).permit(:DetailName, :Feature, :HealthyFeature, :HealthyTip, :SNColor)
  end

  def check_detail_existing
    id = params[:detail_id] || params[:id]
    if Detail.where("id = #{id}").size == 0
      redirect_to root_path
    end
  end
end
