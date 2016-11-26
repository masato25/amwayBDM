class AddSeriesToDetails < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key(:details, :series, dependent: :delete)
  end
end
