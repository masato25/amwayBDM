class DetailImagesController < ApplicationController
  def index
    @photos = DetailImage.order('created_at')
  end

  def new
    @photo = DetailImage.new
  end

  def create
    @photo = DetailImage.new(detail_image_params)
    @photo.detail_id = params[:detail_id]
    if @photo.save
      flash[:success] = "The photo was added!"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      render 'new'
    end
  end

  private

  def detail_image_params
    params.require(:detail_image).permit(:detail_id, :image)
  end
end
