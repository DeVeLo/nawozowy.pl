class CreateGminy < ActiveRecord::Migration[5.0]
  def change
    create_table :gminy do |t|
      t.string :name
      t.string :name_dod
      t.string :teryt
      t.references :wojewodztwo, foreign_key: true

      t.timestamps
    end
  end
end
