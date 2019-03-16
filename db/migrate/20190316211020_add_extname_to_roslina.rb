class AddExtnameToRoslina < ActiveRecord::Migration[5.0]
  def change
    add_column :rosliny, :extname, :string, default: ''
  end
end
