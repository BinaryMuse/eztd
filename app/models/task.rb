class Task < ActiveRecord::Base
  validates_presence_of :text

  def self.completed
    where(:completed => true)
  end

  def self.uncompleted
    where(:completed => false)
  end
end
