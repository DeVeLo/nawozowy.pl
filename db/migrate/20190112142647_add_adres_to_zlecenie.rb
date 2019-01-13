class AddAdresToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_reference :zlecenia, :wojewodztwo, foreign_key: true
    add_reference :zlecenia, :powiat, foreign_key: true
    add_reference :zlecenia, :gmina, foreign_key: true
    add_column :zlecenia, :miejscowosc, :string
    add_column :zlecenia, :powierzchnia, :string
  end
end
