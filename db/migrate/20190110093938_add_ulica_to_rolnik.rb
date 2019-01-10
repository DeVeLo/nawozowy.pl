class AddUlicaToRolnik < ActiveRecord::Migration[5.0]
  def change
    add_column :rolnicy, :ulica, :string
  end
end
