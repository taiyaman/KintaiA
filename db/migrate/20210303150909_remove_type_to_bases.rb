class RemoveTypeToBases < ActiveRecord::Migration[5.1]
  def change
    remove_column :bases, :attendance, :string
  end
end
