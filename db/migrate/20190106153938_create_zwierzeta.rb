class CreateZwierzeta < ActiveRecord::Migration[5.0]
  def change
    create_table :zwierzeta do |t|
      t.string :name
      t.references :gatunek, foreign_key: true
      t.decimal :wspolczynnik

      t.timestamps
    end
  end
end
