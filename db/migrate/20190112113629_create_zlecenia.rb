class CreateZlecenia < ActiveRecord::Migration[5.0]
  def change
    create_table :zlecenia, id: :uuid do |t|
      t.string :name
      t.references :instytucja, foreign_key: true, type: :uuid
      t.references :rolnik, foreign_key: true, type: :uuid
      t.references :wariant, foreign_key: true
      t.string :podstawainna
      t.string :sprawa
      t.references :podstawa, foreign_key: true

      t.timestamps
    end
  end
end
