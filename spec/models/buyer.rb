require 'spec_helper'

describe Buyer do
  it "address 为空的 buyer 是无效的" do
    FactoryGirl.build(:buyer, address: nil).should_not be_valid
  end

  it "address_detail 为空的 buyer 是无效的" do
    FactoryGirl.build(:buyer, address_detail: nil).should_not be_valid
  end

  it "name 为空的 buyer 是无效的" do
    FactoryGirl.build(:buyer, name: nil).should_not be_valid
  end

  it "phone 为空的 buyer 是无效的" do
    FactoryGirl.build(:buyer, phone: nil).should_not be_valid
  end

  it "sns_num 为空的 buyer 是无效的" do
    FactoryGirl.build(:buyer, sns_num: nil).should_not be_valid
  end

  before :each do
    @buyer = FactoryGirl.create :buyer
  end
  describe "#full_address" do
    it "返回买家的详细地址" do
      @buyer.full_address.should eq "浙江省 杭州市 滨江区 网商路"
    end
  end

  describe "#sns" do
    it "返回买家的 sns" do
      @buyer.sns.should eq "QQ:123456"
    end
  end
end
