class AddRownowaznikToAnimal < ActiveRecord::Migration[5.0]
  def change
    add_reference :animals, :rownowaznik, foreign_key: true
  end
end
