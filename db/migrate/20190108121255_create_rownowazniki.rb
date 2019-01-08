class CreateRownowazniki < ActiveRecord::Migration[5.0]
  def change
    create_table :rownowazniki do |t|
      t.references :gatunek, foreign_key: true
      t.references :nazwautrzymania, foreign_key: true
      t.references :sezon, foreign_key: true
      t.decimal :wartosc

      t.timestamps
    end
  end
end
