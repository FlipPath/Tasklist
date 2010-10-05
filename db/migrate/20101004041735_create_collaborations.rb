class CreateCollaborations < ActiveRecord::Migration
  def self.up
    create_table :collaborations do |t|
      t.integer :user_id
      t.integer :list_id
      t.boolean :admin
      
      t.timestamps
    end
  end

  def self.down
    drop_table :collaborations
  end
end
