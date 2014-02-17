class Trade < ActiveRecord::Base
  has_one :buyer, dependent: :destroy
  belongs_to :item

  validates :number, numericality: { only_integer: true}
  validates_associated :buyer
end
