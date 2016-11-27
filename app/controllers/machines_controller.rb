class MachinesController < ApplicationController
  def index
    @machines = Machine.order(:id)
    @plains = Plain.select("id, name").map{|p| [p.name, p.id]}
    @plains.push(["無方案", 0])
    p @plains
  end

  def update
    @machine = Machine.find(params[:id])
    if @machine.update({plain_id: params[:plain_id]})
      flash[:notice] = "更新成功"
    else
      flash[:error] = @machine.errors
    end
    redirect_to action: "index"
  end

  #pending
  def sync_plain_to_machine
  end

  #pending
  def set_up_touch_screen
  end
end
