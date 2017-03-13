class AddPolarExprOnlyToDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :details, :PolarExprOnly, :boolean, default: false
  end
end
