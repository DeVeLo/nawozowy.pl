class AddBobowataToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_reference :uzytki, :bobowata, foreign_key: true
  end
end
