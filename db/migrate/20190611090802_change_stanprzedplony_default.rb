class ChangeStanprzedplonyDefault < ActiveRecord::Migration[5.0]
  def up
    change_column_default :uzytki, :stanprzedplonu, false
    change_column_default :uzytki, :sloma_zebrana, false
  end

  def down
    change_column_default :uzytki, :stanprzedplonu, true
    change_column_default :uzytki, :sloma_zebrana, true
  end
end
