class AddCategoryToBiomarkers < ActiveRecord::Migration[7.1]
  def change
    add_column :biomarkers, :category, :string
  end
end
