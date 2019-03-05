class AddKorektyToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :korekta_azot, :decimal
    add_column :uzytki, :korekta_fosfor, :decimal
    add_column :uzytki, :korekta_potas, :decimal
    add_column :uzytki, :korekta_magnez, :decimal
    add_column :uzytki, :korekta_wapn, :decimal
  end
end
