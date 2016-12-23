class SeriesController < ApplicationController
  before_action :check_session
  before_action :check_brand_existing, only: [:index, :edit, :create, :new]
  skip_before_action :verify_authenticity_token

  def index
    @series = Series.where("brand_id = #{params[:brand_id]}").includes(:brand).order('created_at')

    respond_to do |format|
      format.html
      format.json {
        render :json => @series.to_json( :only => [:id, :SeriesName] )
      }
    end
  end

  def list
    @series = Series.includes(:brand).order('created_at')

    respond_to do |format|
      format.json {
        resp = []
        @series.each{|s|
          resp = resp.push({id: s.id, SeriesName: s.SeriesName, brand_id: s.brand.id, brand_name: s.brand.BrandName})
        }
        render :json => resp.to_json()
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
      flash[:notice] = "新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @series.errors
      redirect_to new_brand_series_path
    end
  end

  def edit
    @series = Series.find(params[:id])
    @image = SeriesBackgroundImage.new()
    @bgimage = SeriesBackgroundImage.where("series_id = #{params[:id]}").first
    @brand_id = params[:brand_id]
    @series_id = params[:id]
  end

  def update
    series = Series.find(params[:id])
    begin
      series.update!(series_params)
      flash[:notice] = "更新成功"
      redirect_to  edit_brand_series_path(params[:brand_id], params[:id])
    rescue
      flash[:error] = "更新失败, 请检查输入选项是否正确"
      redirect_to edit_brand_series_path(params[:brand_id], params[:id])
    end
  end

  def destroy
    @series = Series.find(params[:id])
    if @series.destroy
      flash[:notice] = "删除成功"
    else
      flash[:error] = "删除失败, 请重试"
    end
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
    id = params[:brand_id] || params[:id]
    if Brand.where("id = #{id}").size == 0
      redirect_to root_path
    end
  end
end
