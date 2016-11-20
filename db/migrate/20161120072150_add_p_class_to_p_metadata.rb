class AddPClassToPMetadata < ActiveRecord::Migration[5.0]
  def change
    add_reference :p_metadata, :class, foreign_key: true
  end
end
