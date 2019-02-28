class AddWeglanowaToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :weglanowa, :boolean, default: false
  end
end
