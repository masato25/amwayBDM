class CompositionImagesController < ApplicationController
  def index
    @photos = CompositionImage.order('created_at')
  end

  def new
    @photo = CompositionImage.new
  end

  def create
    @photo = CompositionImage.new(photo_params)
    @photo.detail_id = params[:detail_id]
    if @photo.save
      flash[:success] = "The photo was added!"
      redirect_to  url_for(:controller => :details, :action => :image_upload, :detail_id => @photo.detail_id)
    else
      render 'new'
    end
  end

  private

  def photo_params
    params.require(:composition_images).permit(:detail_id, :image)
  end
end
