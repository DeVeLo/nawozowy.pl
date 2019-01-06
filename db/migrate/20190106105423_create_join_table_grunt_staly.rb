class CreateJoinTableGruntStaly < ActiveRecord::Migration[5.0]
  def change
    create_join_table :grunty, :stale do |t|
      # t.index [:grunt_id, :staly_id]
      # t.index [:staly_id, :grunt_id]
    end
  end
end
