class AddWwwToInstytucja < ActiveRecord::Migration[5.0]
  def change
    add_column :instytucje, :www, :string, default: ''
  end
end
