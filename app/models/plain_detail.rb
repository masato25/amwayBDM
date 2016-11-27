class PlainDetail < ApplicationRecord
  belongs_to :plain
  belongs_to :detail
  validates_uniqueness_of :plain_id, :scope => [:detail_id, :plain_id]
  def detail_name
    Detail.find(self["detail_id"])["DetailName"]
  end
  def series_name
    Detail.find(self["detail_id"]).series_name
  end

  def brand_name
    Detail.find(self["detail_id"]).brand_name
  end

end
