class AddUwagiToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_column :zlecenia, :uwagi, :text, default: ''
  end
end
