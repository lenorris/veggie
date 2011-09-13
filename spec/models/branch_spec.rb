require 'spec_helper'

describe Branch do
  context "validations" do

    it "should not save a branch without a street address" do
      branch = FactoryGirl.build(:branch, :street_address => nil)
      branch.save.should be_false
    end

    it "should not save a branch without a city" do
      branch = FactoryGirl.build(:branch, :city => nil)
      branch.save.should be_false
    end
  end
end
