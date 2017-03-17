class AddAreaColorToSeries < ActiveRecord::Migration[5.0]
  def change
    add_column :series, :AreaColor, :string, default: ""
  end
end
