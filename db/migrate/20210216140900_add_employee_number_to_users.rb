class AddEmployeeNumberToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :employees_number, :integer
  end
end
