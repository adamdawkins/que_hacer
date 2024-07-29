require_relative "../core/todo"

module Persistence
  class TodoMappings
    class << self
      def to_markdown(todo)
        completed = todo.completed? ? "x" : " "
        "- [#{completed}] #{todo.label}"
      end
    end
  end
end
