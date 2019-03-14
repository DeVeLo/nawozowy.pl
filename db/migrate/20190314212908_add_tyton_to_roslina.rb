class AddTytonToRoslina < ActiveRecord::Migration[5.0]
  def change
    add_column :rosliny, :tyton, :boolean, default: false
  end
end
