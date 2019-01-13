class AddPhoneToInstytucja < ActiveRecord::Migration[5.0]
  def change
    add_column :instytucje, :tel, :string
    add_column :instytucje, :fax, :string
    add_column :instytucje, :mail, :string
  end
end
