class DetailsController < ApplicationController
  before_action :check_session
  before_action :check_detail_existing, only: [:edit, :image_upload]

  def index
    check_mysession
    @details = Detail.includes(:series)
    respond_to do |format|
      format.html
      format.json {
        render :json => @details.to_json
      }
    end
  end

  def detail_info_list
    @details = Detail.all
    @respDet = []
    @details.each{|d|
      @respDet = @respDet.push({ id: d["id"],
        text: d["DetailName"],
        series_name: d.series_name,
        brand_name: d.brand_name
      })
    }
    render json: @respDet.to_json
  end

  def new
    @detail = Detail.new
  end

  def create
    p detail_params
    @detail = Detail.new(detail_params)
    @detail.series_id = params["series_id"]
    if @detail.valid?
      @detail.save
      flash[:notice] = "新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @detail.errors
      p @detail.errors
      redirect_to new_detail_path
    end
  end

  def edit
    check_mysession
    @detail = Detail.find(params[:id])
  end

  def update
    @detail = Detail.find(params[:id])
    if @detail.update(detail_params)
      flash[:notice] = "更新成功"
    else
      flash[:error] = @detail.errors
    end
    redirect_to action: "edit"
  end

  def destroy
    @detail = Detail.find(params[:id])
    @detail.destroy
    redirect_to action: "index"
  end

  def image_upload
    check_mysession
    @id = params[:detail_id]
    @detail = Detail.find(@id)
    @photo = DetailImage.new()
    @dphoto = DetailImage.where("detail_id = #{params[:detail_id]}")
    @fphoto = FeatureImage.where("detail_id = #{params[:detail_id]}").first
    @cphoto = CompositionImage.where("detail_id = #{params[:detail_id]}").first
    @qrphoto = QrImage.where("detail_id = #{params[:detail_id]}").first
    @mdphoto = ContentImage.where("detail_id = #{params[:detail_id]}").first
  end

  private

  def detail_params
    params.require(:detail).permit(:DetailName, :Feature, :HealthyFeature, :HealthyTip, :SNColor, :brand_name, :IsShow)
  end

  def check_detail_existing
    id = params[:detail_id] || params[:id]
    if Detail.where("id = #{id}").size == 0
      redirect_to root_path
    end
  end
end
