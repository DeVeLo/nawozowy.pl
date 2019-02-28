class CreateOcenymagnez < ActiveRecord::Migration[5.0]
  def change
    create_table :ocenymagnez do |t|
      t.references :ocena, foreign_key: true
      t.references :kategoria, foreign_key: true
      t.decimal :powyzej
      t.decimal :ponizej

      t.timestamps
    end
  end
end
