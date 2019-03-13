class AddSadToRoslina < ActiveRecord::Migration[5.0]
  def change
    add_column :rosliny, :sad, :boolean, default: false
  end
end
