require 'rails_helper'

RSpec.describe Series, type: :model do
  it "is valid with valid attributes" do
    expect(build(:series)).to be_valid
  end

  it "should have many details" do
    t = Series.reflect_on_association(:detail)
    expect(t.macro).to equal :has_many
  end

end
