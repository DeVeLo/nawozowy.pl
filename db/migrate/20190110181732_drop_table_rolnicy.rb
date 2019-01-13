class DropTableRolnicy < ActiveRecord::Migration[5.0]
  def change
    drop_table :rolnicy
  end
end
