class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :text
      t.boolean :completed, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
