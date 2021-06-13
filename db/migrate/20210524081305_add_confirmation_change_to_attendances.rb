class AddConfirmationChangeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :confirmation_change, :string
  end
end
