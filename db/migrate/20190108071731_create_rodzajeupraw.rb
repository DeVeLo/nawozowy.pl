class CreateRodzajeupraw < ActiveRecord::Migration[5.0]
  def change
    create_table :rodzajeupraw do |t|
      t.string :name

      t.timestamps
    end
  end
end
