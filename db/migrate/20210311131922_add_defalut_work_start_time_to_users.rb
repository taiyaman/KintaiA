class AddDefalutWorkStartTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :defalut_work_start_time, :datetime, default: Time.current.change(hour: 8, min: 30, sec: 0)
  end
end
