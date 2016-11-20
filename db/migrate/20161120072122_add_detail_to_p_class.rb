class AddDetailToPClass < ActiveRecord::Migration[5.0]
  def change
    add_reference :p_classes, :detail, foreign_key: true
  end
end
