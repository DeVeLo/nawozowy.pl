class AddStanna2ToGmina < ActiveRecord::Migration[5.0]
  def change
    add_column :gminy, :stanna, :date
  end
end
