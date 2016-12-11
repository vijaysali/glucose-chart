class CreateGlucoseMeters < ActiveRecord::Migration
  def change
    create_table :glucose_meters do |t|
      t.float :level
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
