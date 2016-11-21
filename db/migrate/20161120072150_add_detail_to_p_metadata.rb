class AddDetailToPMetadata < ActiveRecord::Migration[5.0]
  def change
    add_reference :p_metadata, :detail, foreign_key: true
  end
end
