class AddTypToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_column :zlecenia, :typ, :integer, null: false, default: false
  end
end
