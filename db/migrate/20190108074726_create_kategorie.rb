class CreateKategorie < ActiveRecord::Migration[5.0]
  def change
    create_table :kategorie do |t|
      t.string :name
      t.decimal :zasob

      t.timestamps
    end
  end
end
