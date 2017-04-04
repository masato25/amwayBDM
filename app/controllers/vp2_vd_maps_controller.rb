class Vp2VdMapsController < ApplicationController
  before_action :check_session

  def create
    @vp2vd = Vp2VdMap.new(vp2_vd_map_params)
    vpid = params["vp2_vd_map"]["video_plain_id"]
    logger.info("vpid: #{vpid}")
    logger.info("params: #{params.keys}")
    if @vp2vd.save
      flash[:success] = "新增成功"
      redirect_to :action=>"edit", :controller=>"video_plains", :id => vpid
    else
      flash[:error] = @vp2vd.errors
      redirect_to :action=>"edit", :controller=>"video_plains", :id => vpid
    end
  end

  def update
    @vp2vd = Vp2VdMap.new(vp2_vd_map_params)
    vpid = params["vp2_vd_map"]["video_plain_id"]
    if @vp2vd.update
      flash[:success] = "更新成功"
      redirect_to :action=>"edit", :controller=>"video_plains", :id => vpid
    else
      flash[:error] = @vp2vd.errors
      redirect_to :action=>"edit", :controller=>"video_plains", :id => vpid
    end
  end

  def destroy
    @vp2vd = Vp2VdMap.find(params[:id])
    vpid = @vp2vd["video_plain_id"]
    if @vp2vd.destroy
      flash[:success] = "删除成功"
      redirect_to :action=>"edit", :controller=>"video_plains", :id => vpid
    else
      flash[:error] = @vp2vd.errors
      redirect_to :action=>"edit", :controller=>"video_plains", :id => vpid
    end
  end

  private
  def vp2_vd_map_params
    params.require(:vp2_vd_map).permit(:screen, :video_id, :video_plain_id)
  end
end
