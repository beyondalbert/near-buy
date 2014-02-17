class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.integer :trade_id
      t.integer :member_id
      t.string :name
      t.string :phone
      t.string :address
      t.string :address_detail
      t.integer :sns_type
      t.string :sns_num

      t.timestamps
    end
  end
end
