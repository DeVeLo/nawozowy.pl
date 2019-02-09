class AddIloscToNawoznaturalny < ActiveRecord::Migration[5.0]
  def change
    add_column :nawozynaturalne, :ilosc, :decimal
  end
end
