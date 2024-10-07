class AddClientIdAndExternalIdToBiomarkers < ActiveRecord::Migration[7.1]
  def change
    add_column :biomarkers, :client_id, :string, null: true
    add_column :biomarkers, :external_id, :string, null: true
    add_index :biomarkers, :client_id
    add_index :biomarkers, :external_id
  end
end
