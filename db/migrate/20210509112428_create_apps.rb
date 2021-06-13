class CreateApps < ActiveRecord::Migration[5.1]
  def change
    create_table :apps do |t|
      t.string :Apply
      t.date :month
      t.integer :mark
      t.integer :authorizer
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
