class AddStannaToPowiat < ActiveRecord::Migration[5.0]
  def change
    add_column :powiaty, :stanna, :date
  end
end
