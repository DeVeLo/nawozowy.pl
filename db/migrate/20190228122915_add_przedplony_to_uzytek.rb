class AddPrzedplonyToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :przedplonfosfor, :decimal
    add_column :uzytki, :przedplonpotas, :decimal
  end
end
