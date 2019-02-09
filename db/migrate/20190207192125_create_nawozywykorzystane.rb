class CreateNawozywykorzystane < ActiveRecord::Migration[5.0]
  def change
    create_table :nawozywykorzystane do |t|
      t.references :animal, foreign_key: true
      t.references :nawoznaturalny, foreign_key: true
      t.decimal :ilosc

      t.timestamps
    end
  end
end
