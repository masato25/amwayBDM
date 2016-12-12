class SeriesBackgroundImagesController < ApplicationController
  def create
    begin
      @photo = SeriesBackgroundImage.new(series_background_image_params)
      @photo.series_id = params[:series_id]
      if @photo.save
        flash[:notice] = "上传成功"
      else
        flash[:error] = @photo.errors
      end
      redirect_to  url_for(:controller => :series, :action => :edit, :brand_id => params[:brand_id], :id => params[:series_id])
    rescue Exception => e
      message = e.message
      if message =~ /empty/
        flash[:error] = "缺少档案, 上传失败"
      else
        flash[:error] = message
      end
      redirect_to  url_for(:controller => :series, :action => :edit, :brand_id => params[:brand_id], :id => params[:series_id])
    end
  end

  def destroy
    @photo = SeriesBackgroundImage.find(params[:id])
    if @photo.destroy
      flash[:notice] = "删除成功"
    else
      flash[:error] = @photo.error
    end
    redirect_to  url_for(:controller => :series, :action => :edit, :brand_id => params[:brand_id], :id => params[:series_id])
  end

  private

  def series_background_image_params
    params.require(:series_background_image).permit(:series_id, :image)
  end
end
