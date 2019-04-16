class AddSzukajrolnikaToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :szukajrolnika, :string, default: '', null: false
  end
end
