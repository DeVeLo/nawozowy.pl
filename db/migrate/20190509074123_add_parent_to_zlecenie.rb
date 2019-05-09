class AddParentToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_reference :zlecenia, :parent, index: true, foreign_key: { to_table: :zlecenia }, type: :uuid
  end
end
