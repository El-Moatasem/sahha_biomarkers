class CreateBiomarkers < ActiveRecord::Migration[7.1]
  def change
    create_table :biomarkers do |t|
      t.string :type
      t.json :value
      t.datetime :recorded_at

      t.timestamps
    end
  end
end
