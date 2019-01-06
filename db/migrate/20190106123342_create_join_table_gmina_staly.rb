class CreateJoinTableGminaStaly < ActiveRecord::Migration[5.0]
  def change
    create_join_table :gminy, :stale do |t|
      # t.index [:gmina_id, :staly_id]
      # t.index [:staly_id, :gmina_id]
    end
  end
end
