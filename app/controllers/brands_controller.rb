class BrandsController < ApplicationController
  def index
    @brands = Brand.order('created_at')

    respond_to do |format|
      format.html
      format.json {
        x = []
        #convert to select options
        @brands.each{|h|
          x.push({:id => h.id, :text => h.BrandName})
        }
        render :json => x.to_json( :only => [:id, :text] )
      }
    end
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.valid?
      @brand.save
      flash[:success] = "品牌新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @brand.errors
      redirect_to new_brand_path
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to action: "index"
  end

  private

   def brand_params
      params.require(:brand).permit(:BrandName)
   end
end
