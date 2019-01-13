class CreatePodstawy < ActiveRecord::Migration[5.0]
  def change
    create_table :podstawy do |t|
      t.string :name

      t.timestamps
    end
  end
end
