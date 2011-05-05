class AddOrderToTask < ActiveRecord::Migration
  class Product < ActiveRecord::Base
  def self.up
    add_column :tasks, :ordering, :integer

    # Set a default order based on the current ID-based ordering
    order_index = -1
    Task.all.each do |task|
      order_index += 1
      task.ordering = order_index
      task.save
    end
  end

  def self.down
    remove_column :tasks, :ordering
  end
end
