class AddDefaultToClosedTask < ActiveRecord::Migration
  def self.up
    change_column_default :tasks, :closed, false
    change_column_null :tasks, :closed, true, false
  end
end
