namespace :backup do
  sqlite_path = "/usr/bin/sqlite3"
  sql_file = "db/development.sqlite3"
  desc "TODO"
  task export_db: :environment do
    system("#{sqlite_path} #{sql_file} .dump > restore.sql")
    system("tar -czf public/restore.tar.gz restore.sql")
    system("rm -f restore.sql")
  end

  desc "TODO"
  task import_db: :environment do
    system("tar -xzvf public/restore.tar.gz -C .")
    system("cat restore.sql | #{sqlite_path} #{sql_file}")
    system("rm -f restore.sql")
    system("rm -f public/restore.tar.gz")
  end

  desc "TODO"
  task export_image: :environment do
    system("tar -czf public/image_export.tar.gz public/system")
  end

  desc "TODO"
  task import_image: :environment do
    system("tar -xzvf public/image_export.tar.gz -C public/")
  end

  desc "TODO"
  task clean_db: :environment do
    Brand.delete_all
  end

end
