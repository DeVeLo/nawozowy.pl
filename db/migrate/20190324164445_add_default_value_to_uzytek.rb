class AddDefaultValueToUzytek < ActiveRecord::Migration[5.0]
  def up
    change_column :uzytki, :przedplonfosfor, :decimal, default: 0
    change_column :uzytki, :przedplonpotas, :decimal, default: 0
  end

  def down
    change_column :uzytki, :przedplonfosfor, :decimal, default: nil
    change_column :uzytki, :przedplonpotas, :decimal, default: nil
  end
end
