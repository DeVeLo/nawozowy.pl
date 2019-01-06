class AddStannaToGmina < ActiveRecord::Migration[5.0]
  def change
    add_column :gminy, :stan_na, :date, default: '2019-01-01'
  end
end
