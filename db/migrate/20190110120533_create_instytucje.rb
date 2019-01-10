class CreateInstytucje < ActiveRecord::Migration[5.0]
  def change
    create_table :instytucje, id: :uuid do |t|
      t.string :name
      t.string :nip
      t.string :regon
      t.references :wojewodztwo, foreign_key: true
      t.references :powiat, foreign_key: true
      t.references :gmina, foreign_key: true
      t.string :ulica
      t.string :nrp
      t.string :nrm

      t.timestamps
    end
  end
end
