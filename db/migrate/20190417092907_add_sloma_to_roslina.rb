class AddSlomaToRoslina < ActiveRecord::Migration[5.0]
  def change
    add_column :rosliny, :sloma, :boolean, null: false, default: false
  end
end
