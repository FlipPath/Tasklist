class CreateListAssociations < ActiveRecord::Migration
  def self.up
    create_table :list_associations do |t|
      t.integer :list_id
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :list_associations
  end
end
