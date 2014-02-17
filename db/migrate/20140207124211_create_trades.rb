class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :saler_id
      t.integer :item_id
      t.integer :number
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
