class CreatePhzakresy < ActiveRecord::Migration[5.0]
  def change
    create_table :phzakresy do |t|
      t.string :name
      t.string :odczyn
      t.decimal :od
      t.decimal :do

      t.timestamps
    end
  end
end
