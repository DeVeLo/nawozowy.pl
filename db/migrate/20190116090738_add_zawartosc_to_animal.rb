class AddZawartoscToAnimal < ActiveRecord::Migration[5.0]
  def change
    add_column :animals, :badania, :boolean, default: false
    add_column :animals, :zawartosc, :decimal
  end
end
