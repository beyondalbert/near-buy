class Item < ActiveRecord::Base
  has_one :picture, as: :imageable, dependent: :destroy
  has_many :trades

  validates :price, numericality: true

  def owner
    User.find(self.owner_id)
  end

  def total_sales
    value = 0
    self.trades.map { |t| value += self.price * t.number }
    value
  end

  def sales_volume
    value = 0
    self.trades.map { |t| value += t.number }
    value
  end

  def closed?
    self.status == 2
  end

  def trades_num
    self.trades.size
  end
end
