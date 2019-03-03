class AddTypToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_column :zlecenia, :typ, :boolean, null: false, default: false
  end
end
