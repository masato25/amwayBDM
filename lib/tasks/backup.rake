namespace :backup do
  sqlite_path = "/usr/bin/sqlite3"
  sql_file = "db/#{Rails.env}.sqlite3"
  desc "TODO"
  task export_data: :environment do
    system("#{sqlite_path} #{sql_file} .dump > public/restore.sql")
    system("tar -czf public/backups.tar.gz public/restore.sql public/system")
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
    Machine.delete_all
    system("rm -rf public/system/*")
  end

  desc "A test agrs for Rake task"
  task :test, :message do |t, args|
    puts args[:message]
  end

end
