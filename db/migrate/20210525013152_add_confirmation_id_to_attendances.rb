class AddConfirmationIdToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :confirmation_id, :integer
  end
end
