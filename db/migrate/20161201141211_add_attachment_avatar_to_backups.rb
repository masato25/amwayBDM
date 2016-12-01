class AddAttachmentAvatarToBackups < ActiveRecord::Migration
  def self.up
    change_table :backups do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :backups, :avatar
  end
end
