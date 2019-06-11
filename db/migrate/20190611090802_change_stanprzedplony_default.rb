class ChangeStanprzedplonyDefault < ActiveRecord::Migration[5.0]
  def up
    change_column_default :uzytki, :stanprzedplonu, true
  end

  def down
    change_column_default :uzytki, :stanprzedplonu, false
  end
end
