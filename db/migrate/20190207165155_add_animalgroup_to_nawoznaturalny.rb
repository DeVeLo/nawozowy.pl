class AddAnimalgroupToNawoznaturalny < ActiveRecord::Migration[5.0]
  def change
    add_reference :nawozynaturalne, :animalgroup, foreign_key: true, type: :uuid
  end
end
