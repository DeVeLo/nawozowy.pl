class CreateUzytki < ActiveRecord::Migration[5.0]
  def change
    create_table :uzytki do |t|
      t.string :name
      t.references :kategoria, foreign_key: true
      t.references :rodzajuprawy, foreign_key: true
      t.decimal :nmin
      t.decimal :prognoza

      t.timestamps
    end
  end
end
