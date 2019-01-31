class AddRoslinaToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_reference :uzytki, :roslina, foreign_key: true
  end
end
