class AddDatawplywuToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_column :zlecenia, :datawplywu, :date
  end
end
