class CreateJoinTableGminaPlynny < ActiveRecord::Migration[5.0]
  def change
    create_join_table :gminy, :plynne do |t|
      # t.index [:gmina_id, :plynny_id]
      # t.index [:plynny_id, :gmina_id]
    end
  end
end
