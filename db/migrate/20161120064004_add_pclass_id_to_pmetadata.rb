class AddPclassIdToPmetadata < ActiveRecord::Migration[5.0]
  def change
    add_column :p_metadata, :classID, :integer
  end
end
