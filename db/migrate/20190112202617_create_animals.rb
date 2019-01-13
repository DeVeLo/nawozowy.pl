class CreateAnimals < ActiveRecord::Migration[5.0]
  def change
    create_table :animals do |t|
      t.references :instytucja, foreign_key: true, type: :uuid
      t.references :rolnik, foreign_key: true, type: :uuid
      t.references :zlecenie, foreign_key: true, type: :uuid
      t.references :zwierze, foreign_key: true
      t.references :nazwautrzymania, foreign_key: true
      t.references :systemutrzymania, foreign_key: true
      t.decimal :sztuk

      t.timestamps
    end
  end
end
