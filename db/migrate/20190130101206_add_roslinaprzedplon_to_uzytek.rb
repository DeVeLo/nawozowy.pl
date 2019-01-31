class AddRoslinaprzedplonToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_reference :uzytki, :roslinaprzedplon, foreign_key: true, default: 1
  end
end
