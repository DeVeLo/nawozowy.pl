class AddShortnameToInstytucja < ActiveRecord::Migration[5.0]
  def change
    add_column :instytucje, :shortname, :string, default: ''
  end
end
