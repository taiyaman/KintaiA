class AddWorkEndTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :work_end_time, :datetime
  end
end
