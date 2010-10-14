class CreateGroupAssociations < ActiveRecord::Migration
  def self.up
    create_table :group_associations do |t|
      t.integer :group_id
      t.integer :list_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :group_associations
  end
end
