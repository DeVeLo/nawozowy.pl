class AddSlomazebranaToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :sloma_zebrana, :boolean, null: false, default: false
  end
end
