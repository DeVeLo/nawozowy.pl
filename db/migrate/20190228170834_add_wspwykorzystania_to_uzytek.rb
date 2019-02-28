class AddWspwykorzystaniaToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_reference :uzytki, :wspwykorzystania, foreign_key: true
  end
end
