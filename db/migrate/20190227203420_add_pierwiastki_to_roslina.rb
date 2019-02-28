class AddPierwiastkiToRoslina < ActiveRecord::Migration[5.0]
  def change
    add_column :rosliny, :fosfor, :decimal
    add_column :rosliny, :potas, :decimal
    add_column :rosliny, :magnez, :decimal
  end
end
