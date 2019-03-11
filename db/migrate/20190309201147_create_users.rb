class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :lname
      t.references :instytucja, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
