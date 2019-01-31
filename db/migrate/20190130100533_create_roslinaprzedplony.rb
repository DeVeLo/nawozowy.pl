class CreateRoslinaprzedplony < ActiveRecord::Migration[5.0]
  def change
    create_table :roslinaprzedplony do |t|
      t.string :name
      t.decimal :n

      t.timestamps
    end
  end
end
