class CreateApplies < ActiveRecord::Migration[5.1]
  def change
    create_table :applies do |t|
      t.date :month
      t.integer :mark, null: false, default: 0
      t.integer :authorizer
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
