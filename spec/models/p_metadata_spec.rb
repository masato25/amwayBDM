require 'rails_helper'

RSpec.describe PMetadata, type: :model do
  it "is valid with valid attributes" do
    expect(build(:p_metadata)).to be_valid
  end

end
