class AddMiejscowoscToInstytucja < ActiveRecord::Migration[5.0]
  def change
    add_column :instytucje, :miejscowosc, :string
  end
end
