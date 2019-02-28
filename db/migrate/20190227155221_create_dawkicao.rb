class CreateDawkicao < ActiveRecord::Migration[5.0]
  def change
    create_table :dawkicao do |t|
      t.references :kategoria, foreign_key: true
      t.references :grunt, foreign_key: true
      t.decimal :od
      t.decimal :do
      t.decimal :dawka
      t.references :potrzeba, foreign_key: true

      t.timestamps
    end
  end
end
