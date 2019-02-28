class AddWspwykorzystaniaToNazwautrzymania < ActiveRecord::Migration[5.0]
  def change
    add_reference :nazwyutrzymania, :wspwykorzystania, foreign_key: true
  end
end
