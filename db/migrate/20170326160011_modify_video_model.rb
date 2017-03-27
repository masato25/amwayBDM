class ModifyVideoModel < ActiveRecord::Migration[5.0]
  def change
    remove_reference(:videos, :video_plain, foreign_key: true)
    remove_column(:videos, :screen)
  end
end
