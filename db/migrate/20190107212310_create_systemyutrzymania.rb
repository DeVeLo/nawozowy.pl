class CreateSystemyutrzymania < ActiveRecord::Migration[5.0]
  def change
    create_table :systemyutrzymania do |t|
      t.decimal :produkcja
      t.decimal :zawartosc
      t.references :jednostkautrzymania, foreign_key: true
      t.references :nazwautrzymania, foreign_key: true
      t.references :zwierze, foreign_key: true

      t.timestamps
    end
  end
end
