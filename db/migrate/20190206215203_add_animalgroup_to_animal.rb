class AddAnimalgroupToAnimal < ActiveRecord::Migration[5.0]
  def change
    add_reference :animals, :animalgroup, foreign_key: true, type: :uuid
  end
end
