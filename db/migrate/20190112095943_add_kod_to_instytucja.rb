class AddKodToInstytucja < ActiveRecord::Migration[5.0]
  def change
    add_column :instytucje, :kod, :string
    add_column :instytucje, :poczta, :string
  end
end
