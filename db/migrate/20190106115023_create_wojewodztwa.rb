class CreateWojewodztwa < ActiveRecord::Migration[5.0]
  def change
    create_table :wojewodztwa do |t|
      t.string :name
      t.string :teryt

      t.timestamps
    end
  end
end
