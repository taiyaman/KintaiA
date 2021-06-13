class AddConfirmationChangeStatusToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :confirmation_change_status, :string
  end
end
