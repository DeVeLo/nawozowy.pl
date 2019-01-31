class AddPowierzchniaToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :powierzchnia, :decimal
  end
end
