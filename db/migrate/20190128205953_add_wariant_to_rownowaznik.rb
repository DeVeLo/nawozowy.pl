class AddWariantToRownowaznik < ActiveRecord::Migration[5.0]
  def change
    add_column :rownowazniki, :wariant, :name
  end
end
