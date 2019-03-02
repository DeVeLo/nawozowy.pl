class AddLpToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :lp, :integer
  end
end
