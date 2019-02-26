class AddLpToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_column :zlecenia, :lp, :integer
  end
end
