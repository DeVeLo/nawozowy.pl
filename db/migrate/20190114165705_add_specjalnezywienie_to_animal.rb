class AddSpecjalnezywienieToAnimal < ActiveRecord::Migration[5.0]
  def change
    add_column :animals, :specjalnezywienie, :boolean, default: false
  end
end
