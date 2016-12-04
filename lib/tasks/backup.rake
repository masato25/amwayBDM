namespace :backup do
  sqlite_path = "/usr/bin/sqlite3"
  sql_file = "db/development.sqlite3"
  desc "TODO"
  task export_data: :environment do
    system("#{sqlite_path} #{sql_file} .dump > public/restore.sql")
    system("tar -czf public/backups.tar.gz public/restore.sql public/system")
    system("rm -f public/restore.sql")
  end

  desc "TODO"
  task import_data: :environment do
    system("tar -xzvf public/backups.tar.gz -C .")
    system("cat public/restore.sql | #{sqlite_path} #{sql_file}")
    # system("rm -f public/restore.sql")
    # system("rm -f public/backups.tar.gz")
  end

  desc "TODO"
  task clean_db: :environment do
    Brand.delete_all
    system("rm -rf public/system/*")
  end

end
