class AddRownowaznikToOcenamagnez < ActiveRecord::Migration[5.0]
  def change
    add_column :ocenymagnez, :rownowaznik, :integer
  end
end
