class AddZwierzeToSystemutrzymania < ActiveRecord::Migration[5.0]
  def change
    add_reference :systemyutrzymania, :zwierze, foreign_key: true
  end
end
