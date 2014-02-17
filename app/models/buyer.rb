class Buyer < ActiveRecord::Base
  belongs_to :trade

  validates :address, :address_detail, :name, :phone, :sns_num, presence: true

  def full_address
    province_code = self.address[0..1] + "0000"
    city_code = self.address[0..3] + "00"
    ChinaCity.get(province_code) + " " + ChinaCity.get(city_code) + " " + ChinaCity.get(self.address) + self.address_detail
  end

  def sns
    ["QQ", "POPO", "微信"][self.sns_type - 1] + ":" + self.sns_num
  end
end
