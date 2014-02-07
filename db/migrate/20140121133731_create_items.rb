class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :subject
      t.text :description
      t.float :price
      t.integer :status, default: 1
      t.integer :owner_id

      t.timestamps
    end
  end
end
