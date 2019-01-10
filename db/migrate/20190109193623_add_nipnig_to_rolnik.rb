class AddNipnigToRolnik < ActiveRecord::Migration[5.0]
  def change
    add_column :rolnicy, :nip, :string
    add_column :rolnicy, :nig, :string
  end
end
