class CreateRolnicy < ActiveRecord::Migration[5.0]
  def change
    create_table :rolnicy do |t|
      t.string :name
      t.string :lname
      t.string :gname
      t.references :wojewodztwo, foreign_key: true
      t.references :powiat, foreign_key: true
      t.references :gmina, foreign_key: true
      t.string :miejscowosc
      t.string :nrdom
      t.string :nrmieszkania

      t.timestamps
    end
  end
end
