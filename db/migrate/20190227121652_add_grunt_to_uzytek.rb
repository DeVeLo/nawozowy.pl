class AddGruntToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_reference :uzytki, :grunt, foreign_key: true
  end
end
