require_relative "../../todo"

module Actions
  module Todos
    class Complete
      class << self
        def call(todo)
          Todo.new(label: todo.label, completed: true)
        end
      end
    end
  end
end
