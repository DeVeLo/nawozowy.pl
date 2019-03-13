class AddSadToOcenafosfor < ActiveRecord::Migration[5.0]
  def change
    add_column :ocenyfosfor, :sad, :boolean, default: false
  end
end
