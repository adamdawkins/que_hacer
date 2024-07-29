class Todo
  attr_reader :label

  def initialize(label:, completed: false)
    @label = label
    @completed = completed
  end

  def completed?
    @completed
  end
end
