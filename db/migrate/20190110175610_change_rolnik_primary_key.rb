class ChangeRolnikPrimaryKey < ActiveRecord::Migration[5.0]
  def change
    change_table :rolnicy, uuid: :uuid do |t|
      t.uuid :uuid
      t.remove :id
      t.rename :uuid, :id
    end
  end
end
