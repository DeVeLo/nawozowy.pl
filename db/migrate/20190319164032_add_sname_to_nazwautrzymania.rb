class AddSnameToNazwautrzymania < ActiveRecord::Migration[5.0]
  def change
    add_column :nazwyutrzymania, :sname, :string
  end
end
