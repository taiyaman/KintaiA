class AddChange2ToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :change2, :string
  end
end
