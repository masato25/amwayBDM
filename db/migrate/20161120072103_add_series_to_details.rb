class AddSeriesToDetails < ActiveRecord::Migration[5.0]
  def change
    add_reference :details, :series, foreign_key: true
  end
end
