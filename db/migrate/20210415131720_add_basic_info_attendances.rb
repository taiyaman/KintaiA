class AddBasicInfoAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :defalut_work_start_time, :datetime, default: Time.current.change(hour: 8, min: 30, sec: 0)
    add_column :attendances, :defalut_work_end_time, :datetime, default: Time.current.change(hour: 17, min: 30, sec: 0)
  end
end
