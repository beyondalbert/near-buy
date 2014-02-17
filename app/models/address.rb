class Address < ActiveRecord::Base
  belongs_to :user

  def full_address
    province_code = self.content[0..1] + "0000"
    city_code = self.content[0..3] + "00"
    ChinaCity.get(province_code) + " " + ChinaCity.get(city_code) + " " + ChinaCity.get(self.content) + " " + self.detail
  end
end
