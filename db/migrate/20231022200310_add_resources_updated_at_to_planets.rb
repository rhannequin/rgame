class AddResourcesUpdatedAtToPlanets < ActiveRecord::Migration[7.1]
  def change
    add_column(
      :planets,
      :resources_updated_at,
      :datetime,
      default: -> { "CURRENT_TIMESTAMP" },
      null: false
    )
  end
end
