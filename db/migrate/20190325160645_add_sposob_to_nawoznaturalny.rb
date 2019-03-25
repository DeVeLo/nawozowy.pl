class AddSposobToNawoznaturalny < ActiveRecord::Migration[5.0]
  def change
    add_column :nawozynaturalne, :sposob, :integer, default: 1
  end
end
