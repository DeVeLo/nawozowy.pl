class AddBadaniaToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :badania, :boolean, default: false
  end
end
