class CreateNazwyutrzymania < ActiveRecord::Migration[5.0]
  def change
    create_table :nazwyutrzymania do |t|
      t.string :name

      t.timestamps
    end
  end
end
