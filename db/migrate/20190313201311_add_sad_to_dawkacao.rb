class AddSadToDawkacao < ActiveRecord::Migration[5.0]
  def change
    add_column :dawkicao, :sad, :boolean, default: false
  end
end
