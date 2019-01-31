class AddBobowateToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_reference :uzytki, :bobowate, foreign_key: true
  end
end
