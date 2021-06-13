class AddBaseIdToBases < ActiveRecord::Migration[5.1]
  def change
    add_column :bases, :base_id, :integer
  end
end
