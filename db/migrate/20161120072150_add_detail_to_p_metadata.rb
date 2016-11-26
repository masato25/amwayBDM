class AddDetailToPMetadata < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key(:p_metadata, :details, dependent: :delete)
  end
end
