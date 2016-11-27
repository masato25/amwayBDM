class PhotosController < ApplicationController
  def index
    @photos = Photo.order('created_at')
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:notice] = "The photo was added!"
      redirect_to photos_path
    else
      flash[:error] = @phtot.errors
      render 'new'
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:mtype, :refer_id, :image)
  end
end
