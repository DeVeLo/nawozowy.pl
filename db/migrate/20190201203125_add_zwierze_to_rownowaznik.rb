class AddZwierzeToRownowaznik < ActiveRecord::Migration[5.0]
  def change
    add_reference :rownowazniki, :zwierze, foreign_key: true
  end
end
