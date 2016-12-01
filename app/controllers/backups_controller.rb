require 'rake'

class BackupsController < ApplicationController
  Rake::Task.define_task(:environment)
  def index
    @backups = Backup.new()
    @files = Backup.all()
  end

  def create
    @backups = Backup.new(bakcup_params)
    if @backups.valid?
      @backups.save
      flash[:notice] = "新增成功"
      redirect_to action: "index"
    else
      flash[:error] = @backups.errors
      redirect_to action: "index"
    end
  end

  def generate
    load File.join(Rails.root, 'lib', 'tasks', 'backup.rake')
    flag = false
    flag = system("rake backup:export_db") and system("rake backup:export_image")
    if flag == false
      flash[:error] = "備份失敗, 請在執行一次"
      redirect_to controller: 'backups', action: 'genpage'
    else
      flash[:notice] = "備份成功"
      redirect_to controller: 'backups', action: 'genpage'
    end
  end

  def genpage
    @image_export = {"name": "image_export.tar.gz", "path": "public/image_export.tar.gz"}
    if File.exist?(@image_export[:path])
      @image_export[:update_time] = File.stat("public/image_export.tar.gz").mtime.strftime("%Y-%m-%d %H:%M:%S")
    end
    @restore = {"name": "restore.tar.gz", "path": "public/restore.tar.gz"}
    if File.exist?(@restore[:path])
      @restore[:update_time] =  File.stat("public/restore.tar.gz").mtime.strftime("%Y-%m-%d %H:%M:%S")
    end
  end

  private

  def bakcup_params
    params.require(:backup).permit(:avatar)
  end
end
