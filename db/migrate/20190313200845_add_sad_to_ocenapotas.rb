class AddSadToOcenapotas < ActiveRecord::Migration[5.0]
  def change
    add_column :ocenypotas, :sad, :boolean, default: false
  end
end
