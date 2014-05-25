require 'spec_helper'

describe User do
  it "email为空是无效的" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "email是唯一的" do
    FactoryGirl.create(:user)
    FactoryGirl.build(:user, email: "nb_test@test.com").should_not be_valid
  end

  describe "authenticate" do
    before :each do
      @user = FactoryGirl.create(:user)
    end
    it "如果验证通过，返回用户" do
      User.authenticate("nb_test@test.com", "123456").should eq @user
    end

    it "验证失败，返回nil" do
      User.authenticate("nb_test@test.com", "12345").should eq nil
    end
  end

  describe "#encrypt_password" do
    it "加密用户的明文密码" do
      @user = FactoryGirl.create(:user)
      @user.encrypt_password
      @user.password_hash.should == BCrypt::Engine.hash_secret('123456', @user.password_salt)
    end
  end

  describe "#send_password_reset" do
    it "发送密码重置邮件" do
    end
  end

  describe "#generate_token" do
    it "产生用户的token" do
    end
  end

  describe "#default_address" do
    it "返回用户的默认地址" do
      @user = FactoryGirl.create(:user, :with_addresses)
      @address = FactoryGirl.create :address, content: "330108", default: 1, user_id: @user.id
      @user.default_address.content.should eq "330108"
    end
  end

  describe "#admin?" do
    it "返回用户是否是admin" do
      @user = FactoryGirl.create :user, admin: 1
      @user.admin?.should eq true
    end
  end

  describe "#display_name" do
    it "name为空时，返回用户的email" do
      @user = FactoryGirl.create :user
      @user.display_name.should eq "nb_test@test.com"
    end

    it "name不为空时，返回用户的name" do
      @user = FactoryGirl.create :user, name: "nb"
      @user.display_name.should eq "nb"
    end
  end
end
