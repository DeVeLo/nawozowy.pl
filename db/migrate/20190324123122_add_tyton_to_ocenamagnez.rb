class AddTytonToOcenamagnez < ActiveRecord::Migration[5.0]
  def change
    add_column :ocenymagnez, :korektatyton, :decimal, default: 0
  end
end
