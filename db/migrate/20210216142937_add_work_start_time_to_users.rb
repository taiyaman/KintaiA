class AddWorkStartTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :work_start_time, :datetime
  end
end
