namespace :backup do
  sqlite_path = "/usr/bin/sqlite3"
  sql_file = "db/#{Rails.env}.sqlite3"
  desc "TODO"
  task export_data: :environment do
    system("#{sqlite_path} #{sql_file} .dump > public/restore.sql")
    system("tar -czf public/backups.tar.gz public/restore.sql public/system public/media")
    system("rm -f public/restore.sql")
  end

  desc "TODO"
  task :import_data, [:file_name, :environment] do |t, args|
    system("tar -xzvf public/backups/#{args[:file_name]} -C .")
    system("cat public/restore.sql | #{sqlite_path} #{sql_file}")
    system("rm -f public/restore.sql")
  end

  desc "TODO"
  task clean_db: :environment do
    Brand.delete_all
    Series.delete_all
    Detail.delete_all
    PMetadata.delete_all
    Video.delete_all
    system("rm -rf public/system/*")
    system("rm -rf public/media/*")
  end

  desc "A test agrs for Rake task"
  task :test, :message do |t, args|
    puts args[:message]
  end

  desc "init machines list"
  task :create_machine do |t, args|
    Machine.delete_all
    20.times do |l|
      next if l == 0
      a = Machine.new({
        name: "m#{l}",
      })
      if a.save

      else
        p a.errors
      end
    end
  end

end
