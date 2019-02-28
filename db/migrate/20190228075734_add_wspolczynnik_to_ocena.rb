class AddWspolczynnikToOcena < ActiveRecord::Migration[5.0]
  def change
    add_column :oceny, :wspolczynnik, :decimal
  end
end
