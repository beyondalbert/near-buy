class Item < ActiveRecord::Base
  has_one :picture, as: :imageable, dependent: :destroy

  validates :price, numericality: true

  def owner
    User.find(self.owner_id)
  end
end
