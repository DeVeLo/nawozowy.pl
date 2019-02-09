class CreateAnimalgroups < ActiveRecord::Migration[5.0]
  def change
    create_table :animalgroups, id: :uuid do |t|
      t.string :name
      t.references :instytucja, foreign_key: true, type: :uuid
      t.references :rolnik, foreign_key: true, type: :uuid
      t.references :zlecenie, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
