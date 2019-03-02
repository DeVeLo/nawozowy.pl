class AddRejestrToZlecenie < ActiveRecord::Migration[5.0]
  def change
    add_column :zlecenia, :rejestr, :integer
  end
end
