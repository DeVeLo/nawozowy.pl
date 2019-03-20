class AddDatawydrukuToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_column :zlecenia, :datawydruku, :date
    add_column :zlecenia, :zmiendatewydruku, :boolean, default: false
  end
end
