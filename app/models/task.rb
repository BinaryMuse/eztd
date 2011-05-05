class Task < ActiveRecord::Base
  validates_presence_of :text
  default_scope order(:ordering)
  attr_accessible :text, :ordering, :completed

  before_save :check_order
  before_create :create_default_order

  def self.completed
    where(:completed => true)
  end

  def self.uncompleted
    where(:completed => false)
  end

  private

    def create_default_order
      return true unless self.ordering.nil?

      max_task  = Task.unscoped.select(:ordering).order('ordering DESC').limit(1)
      max_order = max_task.any? ? max_task.first.ordering : 0
      self.ordering = max_order + 1
    end

    # Check to see if the order changed
    # If it did, modify the order of the other tasks before or after it.
    def check_order
      return true unless persisted?

      logger.info "#{changes['ordering']}"
      if values = changes['ordering']
        old_value = values[0]
        new_value = values[1]
        logger.info "Old value: #{old_value}"
        logger.info "New value: #{new_value}"

        return if old_value == new_value # should never happen
        if new_value > old_value
          move_up_to_position(old_value, new_value)
        else
          move_down_to_position(old_value, new_value)
        end
      end
    end

    def move_up_to_position(old_value, value)
      Task.connection.execute "UPDATE tasks SET ordering = ordering - 1 WHERE ordering > #{old_value} AND ordering <= #{value}"
      # parameterized query?
    end

    def move_down_to_position(old_value, value)
      Task.connection.execute "UPDATE tasks SET ordering = ordering + 1 WHERE ordering < #{old_value} AND ordering >= #{value}"
      # parameterized query?
    end
end
