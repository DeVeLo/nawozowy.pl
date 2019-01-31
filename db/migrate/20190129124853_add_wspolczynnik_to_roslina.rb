class AddWspolczynnikToRoslina < ActiveRecord::Migration[5.0]
  def change
    add_column :rosliny, :wspolczynnik, :decimal, default: 0.6
  end
end
