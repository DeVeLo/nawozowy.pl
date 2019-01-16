class AddZlecenieToUzytek < ActiveRecord::Migration[5.0]
  def change
    add_reference :uzytki, :instytucja, foreign_key: true, type: :uuid
    add_reference :uzytki, :rolnik, foreign_key: true, type: :uuid
    add_reference :uzytki, :zlecenie, foreign_key: true, type: :uuid
  end
end
