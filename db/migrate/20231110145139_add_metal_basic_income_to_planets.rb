class AddMetalBasicIncomeToPlanets < ActiveRecord::Migration[7.1]
  def change
    add_column :planets, :metal_basic_income, :integer, default: 1, null: false
  end
end
