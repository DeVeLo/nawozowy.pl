class CreateTableRolnicy < ActiveRecord::Migration[5.0]
  def change
    create_table :rolnicy, id: :uuid do |t|
      t.string :name
      t.string :lname
      t.string :gname
      t.references :wojewodztwo, foreign_key: true
      t.references :powiat, foreign_key: true
      t.references :gmina, foreign_key: true
      t.string :miejscowosc
      t.string :nrdom
      t.string :nrmieszkania
      t.string :nip
      t.string :nig
      t.string :ulica

      t.timestamps
    end

    add_reference :rolnicy, :instytucja, foreign_key: true, type: :uuid
  end
end
