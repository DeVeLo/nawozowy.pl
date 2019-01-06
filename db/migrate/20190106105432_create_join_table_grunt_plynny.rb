class CreateJoinTableGruntPlynny < ActiveRecord::Migration[5.0]
  def change
    create_join_table :grunty, :plynne do |t|
      # t.index [:grunt_id, :plynny_id]
      # t.index [:plynny_id, :grunt_id]
    end
  end
end
