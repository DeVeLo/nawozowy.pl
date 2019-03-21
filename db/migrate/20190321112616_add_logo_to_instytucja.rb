class AddLogoToInstytucja < ActiveRecord::Migration[5.0]
  def change
    add_column :instytucje, :logo, :string, default: ''
  end
end
