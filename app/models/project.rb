class Project
  attr_accessor :tasks, :due_date

  def self.velocity_length_in_days
    21
  end

  def initialize
    @tasks = []
  end

  def incompleted_tasks
    tasks.reject(&:complete?)
  end

  def done?
    incompleted_tasks.empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    incompleted_tasks.sum(&:size)
  end

  def completed_velocity
    tasks.sum(&:points_toward_velocity)
  end

  def current_rate
    completed_velocity * 1.0 / Project.velocity_length_in_days
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    return false if projected_days_remaining.nan?
    (Date.today + projected_days_remaining) <= due_date
  end
end
