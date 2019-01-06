class CreatePlynne < ActiveRecord::Migration[5.0]
  def change
    create_table :plynne do |t|
      t.date :od
      t.date :do

      t.timestamps
    end
  end
end
