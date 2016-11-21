class FeatureImagesController < ApplicationController
  def index
    @photos = FeatureImage.order('created_at')
  end

  def new
    @photo = FeatureImage.new
  end

  def create
    @photo = FeatureImage.new(photo_params)
    if @photo.save
      flash[:success] = "The photo was added!"
      redirect_to photos_path
    else
      render 'new'
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:detail_id, :image)
  end
end
