class CreatePowiaty < ActiveRecord::Migration[5.0]
  def change
    create_table :powiaty do |t|
      t.string :name
      t.string :teryt
      t.references :wojewodztwo, foreign_key: true

      t.timestamps
    end
  end
end
