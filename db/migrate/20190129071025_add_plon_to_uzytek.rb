class AddPlonToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :plon, :decimal
  end
end
