class ChangePriceFormatInDetailTable < ActiveRecord::Migration[5.0]
  def change 
    change_column(:p_metadata, :Price, :string)
  end
end
