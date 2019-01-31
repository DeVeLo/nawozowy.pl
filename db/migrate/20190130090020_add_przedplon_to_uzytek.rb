class AddPrzedplonToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :przedplon, :decimal, default: 0.0
  end
end
