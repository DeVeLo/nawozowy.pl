class DropTableZlecenie < ActiveRecord::Migration[5.0]
  def change
    drop_table :zlecenia
  end
end
