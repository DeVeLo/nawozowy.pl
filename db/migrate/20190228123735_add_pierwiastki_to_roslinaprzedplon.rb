class AddPierwiastkiToRoslinaprzedplon < ActiveRecord::Migration[5.0]
  def change
    add_column :roslinaprzedplony, :fosfor, :decimal
    add_column :roslinaprzedplony, :potas, :decimal
    add_column :roslinaprzedplony, :mnoznik, :decimal
  end
end
