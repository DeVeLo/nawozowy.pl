class AddPhToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_column :uzytki, :ph, :decimal
  end
end
