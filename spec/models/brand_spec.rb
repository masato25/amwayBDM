require 'rails_helper'

RSpec.describe Brand, type: :model do

  it "is valid with valid attributes" do
    expect(build(:brand)).to be_valid
  end

  it "should have many series" do
    t = Brand.reflect_on_association(:series)
    expect(t.macro).to equal :has_many
  end

end
