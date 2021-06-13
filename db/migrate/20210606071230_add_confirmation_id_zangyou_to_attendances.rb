class AddConfirmationIdZangyouToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :confirmation_id_zangyou, :integer
  end
end
