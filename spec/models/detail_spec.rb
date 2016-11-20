require 'rails_helper'

RSpec.describe Detail, type: :model do
  it "is valid with valid attributes" do
    expect(build(:detail)).to be_valid
  end

  it "should have many details" do
    t = Detail.reflect_on_association(:p_class)
    expect(t.macro).to equal :has_many
  end

end
