class AddIloscnapoleToNawozwykorzystany < ActiveRecord::Migration[5.0]
  def change
    add_column :nawozywykorzystane, :ilosc_na_pole, :decimal
  end
end
