class AddAttendance2ToBases < ActiveRecord::Migration[5.1]
  def change
    add_column :bases, :attendance, :string
  end
end
