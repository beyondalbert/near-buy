class AddSnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sns_type, :integer
    add_column :users, :sns_num, :string
  end
end
