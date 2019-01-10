class AddStannaToWojewodztwo < ActiveRecord::Migration[5.0]
  def change
    add_column :wojewodztwa, :stanna, :date
  end
end
