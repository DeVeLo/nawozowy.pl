class AddBilansnToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_column :zlecenia, :bilansn, :boolean, default: false
  end
end
