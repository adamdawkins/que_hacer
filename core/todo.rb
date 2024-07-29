class Todo
  attr_reader :label

  def initialize(label:)
    @label = label
    @completed = false
  end

  def completed?
    @completed
  end
end
