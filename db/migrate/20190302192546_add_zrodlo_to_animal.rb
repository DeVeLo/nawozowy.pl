class AddZrodloToAnimal < ActiveRecord::Migration[5.0]
  def change
    add_column :animals, :zrodlo, :boolean, null: false, default: false
  end
end
