class CreateWspiwykorzystania < ActiveRecord::Migration[5.0]
  def change
    create_table :wspiwykorzystania do |t|
      t.string :name
      t.decimal :wsp_fosfor_i_rok
      t.decimal :wsp_potas_i_rok
      t.decimal :wsp_magnez_i_rok
      t.decimal :wsp_fosfor_ii_rok
      t.decimal :wsp_potas_ii_rok
      t.decimal :wsp_magnez_ii_rok

      t.timestamps
    end
  end
end
