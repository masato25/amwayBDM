require 'rails_helper'

RSpec.describe Detail, type: :model do
  it "is valid with valid attributes" do
    expect(build(:detail)).to be_valid
  end

  it "should have many p_metadata" do
    t = Detail.reflect_on_association(:p_metadata)
    expect(t.macro).to equal :has_many
  end
end
