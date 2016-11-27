class BrandsController < ApplicationController
  before_action :check_session

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
      flash[:notice] = "品牌新增成功"
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

  def login
    if @session
      redirect_to action: "index"
    end
  end

  def logon
    if params["password"] == ENV["admin_password"]
      cookies[:msession] = ENV["api_key"]
      redirect_to action: "index"
    else
      flash[:error] = "密碼錯誤, 請重試或洽詢管理者"
      redirect_to :root
    end
  end

  def logout
    cookies.delete :msession
    redirect_to :root
  end

  private

   def brand_params
      params.require(:brand).permit(:BrandName)
   end
end
