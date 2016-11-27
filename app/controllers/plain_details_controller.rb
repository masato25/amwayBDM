class PlainDetailsController < ApplicationController
  before_action :check_session, :except => [:update_deatils]
  skip_before_action :verify_authenticity_token, :only => [:update_deatils]

  def create
    @pl_detail = PlainDetail.new(plain_detail_params)
    @pl_detail.plain_id = params[:plain_id]
    @pl_detail.detail_id = params[:detail_id]
    if @pl_detail.save
      flash[:notice] = "新增成功"
    else
      flash[:error] = @pl_detail.errors
    end
    redirect_to edit_plain_path(params[:plain_id])
  end

  def update
    @pl_detail = PlainDetail.find(params[:pl_detail_id])
    if @pl_detail.update(plain_detail_params)
      flash[:notice] = "更新成功"
    else
      flash[:error] = @pl_detail.errors
    end
    redirect_to edit_plain_path(params[:plain_id])
  end

  def destroy
    @plain = PlainDetail.find(params[:id])
    if @plain.destroy
      flash[:notice] = "刪除成功"
    else
      flash[:error] = @plain.errors
    end
    redirect_to edit_plain_path(params[:plain_id])
  end

  def update_deatils
    respon = {}
    if !params.has_key?("id") && !params.has_key?("details") && params["details"].kind_of?(Array)
      respon["errors"] = ["you missing plain id or details, please check your input"]
    else
      row_affect = 0
      err_row = 0
      errors = []
      params["details"].each{|d|
        if d.has_key?("identity_id")
          pl_detail = PlainDetail.find(d["identity_id"])
          if pl_detail
            pl_detail.update(
              ScreenIndex: d["ScreenIndex"] || pl_detail["ScreenIndex"],
              TouchRect: d["TouchRect"] || pl_detail["TouchRect"]
            )
            row_affect += 1
            if pl_detail.errors
              errors = pl_detail.errors
            end
          else
            errors = errors.push("not found matched detail of this plain -> #{d["identity_id"]}")
            err_row += 1
          end
        else
          errors = errors.push("missing detail_id for #{d.to_json}")
          err_row += 1
        end
      }
      respon["row_affect"] = row_affect
      respon["err_row"] = err_row
      respon["errors"] = errors
    end
    render json: respon
  end
  
  private

  def plain_detail_params
    params.require(:plain_detail).permit(:plain_id, :detail_id, :ScreenIndex, :TouchRect)
  end

end
