require 'rails_helper'

RSpec.describe PClass, type: :model do
  it "is valid with valid attributes" do
    expect(build(:p_class)).to be_valid
  end

  it "should have many details" do
    t = PClass.reflect_on_association(:p_metadata)
    expect(t.macro).to equal :has_many
  end
end
