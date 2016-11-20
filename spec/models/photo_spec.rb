require 'rails_helper'

RSpec.describe Photo, type: :model do
  it "is valid with valid attributes" do
    expect(build(:photo)).to be_valid
  end

end
