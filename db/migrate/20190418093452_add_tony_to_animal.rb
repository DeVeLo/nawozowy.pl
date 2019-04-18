class AddTonyToAnimal < ActiveRecord::Migration[5.0]
  def change
    add_column :animals, :tony, :decimal, null: false, default: 0
  end
end
