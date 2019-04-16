class AddKeywordsToRolnik < ActiveRecord::Migration[5.0]
  def change
    add_column :rolnicy, :keywords, :text, null: false, default: ''
  end
end
