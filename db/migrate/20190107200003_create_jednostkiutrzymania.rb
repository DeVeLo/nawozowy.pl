class CreateJednostkiutrzymania < ActiveRecord::Migration[5.0]
  def change
    create_table :jednostkiutrzymania do |t|
      t.string :produkcja
      t.string :zawartosc

      t.timestamps
    end
  end
end
