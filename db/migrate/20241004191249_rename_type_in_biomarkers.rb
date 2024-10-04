class RenameTypeInBiomarkers < ActiveRecord::Migration[7.0]
  def change
    rename_column :biomarkers, :type, :biomarker_type
  end
end
