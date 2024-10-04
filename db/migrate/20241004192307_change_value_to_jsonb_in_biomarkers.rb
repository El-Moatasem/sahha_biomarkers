class ChangeValueToJsonbInBiomarkers < ActiveRecord::Migration[7.1]
  def change
    change_column :biomarkers, :value, :jsonb, using: 'value::jsonb'
  end
end
