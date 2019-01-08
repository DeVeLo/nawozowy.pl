class CreateSezony < ActiveRecord::Migration[5.0]
  def change
    create_table :sezony do |t|
      t.string :name

      t.timestamps
    end
  end
end
