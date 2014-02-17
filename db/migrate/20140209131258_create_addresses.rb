class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :content
      t.string :detail
      t.integer :user_id
      t.boolean :default, default: false

      t.timestamps
    end
  end
end
