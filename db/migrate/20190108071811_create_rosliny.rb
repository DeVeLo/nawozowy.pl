class CreateRosliny < ActiveRecord::Migration[5.0]
  def change
    create_table :rosliny do |t|
      t.string :name
      t.decimal :pobranie
      t.references :rodzajuprawy, foreign_key: true

      t.timestamps
    end
  end
end
