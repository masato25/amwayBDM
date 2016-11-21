class SeriesController < ApplicationController
  before_action :check_brand_existing

  def index
    @series = Series.where("brand_id = #{params[:brand_id]}").order('created_at')

    respond_to do |format|
      format.html
      format.json {
        render :json => @series.to_json( :only => [:id, :SeriesName] )
      }
    end
  end

  def new
    @brand = params[:brand_id]
    @series = Series.new()
  end

  def create
    @series = Series.new(series_params)
    @series.brand_id = params[:brand_id]
    if @series.valid?
      @series.save
      flash[:success] = "產品系列新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @series.errors
      redirect_to new_brand_series_path
    end
  end

  def destroy
    @series = Series.find(params[:id])
    @series.destroy
    redirect_to brand_series_path
  end

  private

  def series_params
     params.require(:series).permit(:SeriesName, :TitleColor)
  end

  def check_brand_existing
    if Brand.where("id = #{params[:brand_id]}").size == 0
      redirect_to root_path
    end
  end
end
