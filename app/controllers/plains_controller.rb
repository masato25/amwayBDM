class PlainsController < ApplicationController
  before_action :check_plain_existing, only: [:edit]
  def index
    @plains = Plain.order('created_at')
  end

  def new
    @plain = Plain.new()
  end

  def create
    @plain = Plain.new(plain_params)
    if @plain.valid?
      @plain.save
      flash[:success] = "樣板新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @plain.errors
      redirect_to new_plain_path
    end
  end

  def edit
    @plain = Plain.find(params[:id])
    @pl_detail = PlainDetail.new()
    default_nscreen = 3
    if ENV["number_of_screen"] =~ /^\d+$/
      default_nscreen = ENV["number_of_screen"].to_i
    end
    @number_of_screen = (1..default_nscreen).to_a
    @pl_details = PlainDetail.where("plain_id = #{params[:id]}")
  end


  def destroy
    @plain = Plain.find(params[:id])
    if @plain.destroy
      Machine.where("plain_id = #{params[:id]}").update_all("plain_id = 0")
    end
    redirect_to action: "index"
  end

  private

  def plain_params
    params.require(:plain).permit(:name)
  end

  def check_plain_existing
    id = params[:id]
    if Plain.where("id = #{id}").size == 0
      redirect_to action: "index"
    end
  end
end
