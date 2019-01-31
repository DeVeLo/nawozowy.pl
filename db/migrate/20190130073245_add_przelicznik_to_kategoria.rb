class AddPrzelicznikToKategoria < ActiveRecord::Migration[5.0]
  def change
    add_column :kategorie, :przelicznik, :decimal
  end
end
