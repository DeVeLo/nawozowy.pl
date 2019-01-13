class AddKodToRolnik < ActiveRecord::Migration[5.0]
  def change
    add_column :rolnicy, :kod, :string
    add_column :rolnicy, :poczta, :string
  end
end
