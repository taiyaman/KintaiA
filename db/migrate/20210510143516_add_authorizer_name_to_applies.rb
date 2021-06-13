class AddAuthorizerNameToApplies < ActiveRecord::Migration[5.1]
  def change
    add_column :applies, :authorizer_name, :string
  end
end
