require 'spec_helper'

describe Address do
  describe "#full_address" do
    it "返回地址的详细地址" do
      @address = FactoryGirl.create :address, content: "330108"
      @address.full_address.should eq "浙江省 杭州市 滨江区 网商路"
    end
  end
end
