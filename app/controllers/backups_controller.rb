require 'rake'

class BackupsController < ApplicationController
  before_action :check_session

  Rake::Task.define_task(:environment)
  def index
    check_mysession
    @backups = Backup.new()
    @files = Backup.all()
  end

  def create
    @backups = Backup.new(bakcup_params)
    file_name = @backups.avatar_file_name
    logger.info("filename = #{file_name}")
    if @backups.valid?
      @backups.save
      if system("rake backup:clean_db")
        if system("rake backup:import_data[#{file_name}]")
          Backup.delete_all
          Video.delete_all
          system("rm -f public/backups/*")
          system("rm -f public/meida/*")
        end
      end
      flash[:notice] = "汇入成功"
      redirect_to action: "index"
    else
      flash[:error] = @backups.errors
      redirect_to action: "index"
    end
  end

  def generate
    load File.join(Rails.root, 'lib', 'tasks', 'backup.rake')
    flag = false
    flag = system("rake backup:export_data")
    if flag == false
      flash[:error] = "备份失败, 请在执行一次"
      redirect_to controller: 'backups', action: 'genpage'
    else
      flash[:notice] = "备份成功"
      redirect_to controller: 'backups', action: 'genpage'
    end
  end

  def genpage
    check_mysession
    @data_export = {"name": "backups.tar.gz", "path": "public/backups.tar.gz"}
    if File.exist?(@data_export[:path])
      @data_export[:update_time] = File.stat("public/backups.tar.gz").mtime.strftime("%Y-%m-%d %H:%M:%S")
    end
  end

  private

  def bakcup_params
    params.require(:backup).permit(:avatar)
  end
end
