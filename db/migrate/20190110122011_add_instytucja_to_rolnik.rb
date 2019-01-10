class AddInstytucjaToRolnik < ActiveRecord::Migration[5.0]
  def change
    add_reference :rolnicy, :instytucja, foreign_key: true, type: :uuid
  end
end
