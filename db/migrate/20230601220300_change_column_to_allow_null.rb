class ChangeColumnToAllowNull < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :date_of_birth,:date, null: true 
  end

  def down
    change_column :users, :date_of_birth,:date, null: false
  end
end
