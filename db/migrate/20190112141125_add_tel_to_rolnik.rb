class AddTelToRolnik < ActiveRecord::Migration[5.0]
  def change
    add_column :rolnicy, :tel, :string
    add_column :rolnicy, :kom, :string
    add_column :rolnicy, :mail, :string
  end
end
