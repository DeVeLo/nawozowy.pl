class AddPierwiastkiToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :fosfor, :decimal
    add_column :uzytki, :potas, :decimal
    add_column :uzytki, :magnez, :decimal
  end
end
