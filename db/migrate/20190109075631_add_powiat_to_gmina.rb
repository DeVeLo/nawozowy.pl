class AddPowiatToGmina < ActiveRecord::Migration[5.0]
  def change
    add_reference :gminy, :powiat, foreign_key: true
  end
end
