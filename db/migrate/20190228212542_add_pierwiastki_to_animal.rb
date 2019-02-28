class AddPierwiastkiToAnimal < ActiveRecord::Migration[5.0]
  def change
    add_column :animals, :fosfor, :decimal
    add_column :animals, :potas, :decimal
    add_column :animals, :magnez, :decimal
    add_column :animals, :wapn, :decimal
  end
end
