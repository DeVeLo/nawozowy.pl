class ChangeRolnicyPrimaryKey < ActiveRecord::Migration[5.0]
  def change
    change_column :rolnicy, :id, :uuid, unique: true, null: false, auto_increment: true
  end
end
