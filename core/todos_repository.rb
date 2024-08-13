require_relative "todo"

class TodosRepository
  def initialize(todos = [])
    @todos = todos
  end

  def add(label)
    @todos + [Todo.new(label:)]
  end

  def all
    @todos
  end

  def remove(index)
    @todos.each_with_index.map do |todo, idx|
      todo unless idx == index
    end.compact
  end

  def count_active
    active_todos.count
  end

  def clear_completed
    active_todos
  end

  private

  def active_todos
    @active_todos ||= @todos.reject(&:completed?)
  end
end
