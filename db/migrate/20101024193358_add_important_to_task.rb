class AddImportantToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :important, :boolean, :default => false
  end

  def self.down
    remove_column :tasks, :important
  end
end
