class ModifyIndexOfDetailPlain < ActiveRecord::Migration[5.0]
  def change
    remove_index :plain_details, [:plain_id, :detail_id]
    # add_index :plain_details, [:plain_id, :detail_id, :ScreenIndex], :unique => true
  end
end
