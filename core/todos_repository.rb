class TodosRepository
  def initialize(todos = [])
    @todos = todos
  end

  def add(label)
    @todos + [Todo.new(label:)]
  end
end