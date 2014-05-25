require 'spec_helper'

describe Item do
  it "item 的价格必须是数字" do
    FactoryGirl.build(:item, price: "test").should_not be_valid
  end

  describe "#owner" do
    it "返回 item 的所有者" do
      @user = FactoryGirl.create :user
      @item = FactoryGirl.create :item, owner_id: @user.id
      @item.owner.should eq @user
    end
  end

  describe "#total_sales" do
    it "返回 item 的总销售额" do
      @item = FactoryGirl.create :item, :with_trades
      @item.total_sales.should eq 108
    end
  end

  describe "#sales_volume" do
    it "返回 item 的总销售量" do
      @item = FactoryGirl.create :item, :with_trades
      @item.total_sales.should eq 108
    end
  end

  describe "#closed?" do
    it "返回 item 是否已经发货" do
      @item = FactoryGirl.create :item
      @item.closed?.should eq true
    end
  end

  describe "#trades_nnum" do
    it "返回 item 的销售量" do
      @item = FactoryGirl.create :item, :with_trades
      @item.trades_num.should eq 2
    end
  end
end
