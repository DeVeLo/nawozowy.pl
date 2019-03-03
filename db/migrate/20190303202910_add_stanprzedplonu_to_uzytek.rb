class AddStanprzedplonuToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :stanprzedplonu, :boolean, null: false, default: false
  end
end
