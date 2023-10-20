class AddMetalToPlanets < ActiveRecord::Migration[7.1]
  def change
    add_column :planets, :metal, :integer, null: false, default: 0
  end
end
