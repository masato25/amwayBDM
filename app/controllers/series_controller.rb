class SeriesController < ApplicationController
  before_action :check_brand_existing, only: [:index, :edit, :create, :new]

  def index
    @series = Series.where("brand_id = #{params[:brand_id]}").includes(:brand).order('created_at')

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

  def edit
    @series = Series.find(params[:id])
  end

  def update
    series = Series.find(params[:id])
    if series.update!(series_params)
      flash[:success] = "更新成功"
      redirect_to  edit_brand_series_path(params[:brand_id], params[:id])
    else
      flash[:success] = "更新失敗, 請檢查輸入選項是否正確"
      redirect_to edit_brand_series_path(params[:brand_id], params[:id])
    end
  end

  def destroy
    @series = Series.find(params[:id])
    @series.destroy
    redirect_to action: "index"
  end

  def find_series
    brand_id = params[:brand_id]
    @series = Series.where("brand_id = #{brand_id}").select("SeriesName, id")
    x = []
    #convert to select options
    @series.each{|h|
      x.push({:id => h.id, :text => h.SeriesName})
    }
    render :json => x.to_json
  end

  private

  def series_params
     params.require(:series).permit(:SeriesName, :TitleColor)
  end

  def check_brand_existing
    id = params[:brand_id] || params[:od]
    if Brand.where("id = #{id}").size == 0
      redirect_to root_path
    end
  end
end
