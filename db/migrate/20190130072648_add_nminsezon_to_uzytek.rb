class AddNminsezonToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :nminsezon, :boolean, default: false
  end
end
