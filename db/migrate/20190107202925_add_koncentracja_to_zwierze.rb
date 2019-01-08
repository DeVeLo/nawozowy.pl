class AddKoncentracjaToZwierze < ActiveRecord::Migration[5.0]
  def change
    add_column :zwierzeta, :koncentracja, :decimal, null: true
  end
end
