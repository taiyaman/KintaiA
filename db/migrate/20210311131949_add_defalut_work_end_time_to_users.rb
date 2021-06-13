class AddDefalutWorkEndTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :defalut_work_end_time, :datetime, default: Time.current.change(hour: 17, min: 30, sec: 0)
  end
end
