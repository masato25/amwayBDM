class AddVideoPlainIdToMachines < ActiveRecord::Migration[5.0]
  def change
    add_column :machines, :video_plain_id, :integer, :default => 0
  end
end
