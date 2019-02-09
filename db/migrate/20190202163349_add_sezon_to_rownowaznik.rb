class AddSezonToRownowaznik < ActiveRecord::Migration[5.0]
  def change
    add_column :rownowazniki, :jesien, :decimal
    add_column :rownowazniki, :wiosna, :decimal
  end
end
