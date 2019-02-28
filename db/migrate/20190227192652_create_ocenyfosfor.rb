class CreateOcenyfosfor < ActiveRecord::Migration[5.0]
  def change
    create_table :ocenyfosfor do |t|
      t.references :kategoria, foreign_key: true
      t.references :ocena, foreign_key: true
      t.boolean :weglanowa
      t.decimal :powyzej
      t.decimal :ponizej

      t.timestamps
    end
  end
end
