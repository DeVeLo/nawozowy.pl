class RemoveStanNaFromGmina < ActiveRecord::Migration[5.0]
  def change
    remove_column :gminy, :stan_na, :date
  end
end
