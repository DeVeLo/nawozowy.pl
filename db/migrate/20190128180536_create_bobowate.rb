class CreateBobowate < ActiveRecord::Migration[5.0]
  def change
    create_table :bobowate do |t|
      t.string :name
      t.decimal :n

      t.timestamps
    end
  end
end
