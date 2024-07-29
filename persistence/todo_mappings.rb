require_relative "../core/todo"

module Persistence
  class TodoMappings
    class << self
      def to_markdown(todo)
        completed = todo.completed? ? "x" : " "
        "- [#{completed}] #{todo.label}"
      end

      def to_value(markdown)
        match_data = /^- \[(?<completed>.)\] (?<label>.*)$/.match(markdown)

        label = match_data["label"]
        completed = match_data["completed"] == "x"

        Todo.new(label:, completed:)
      end
    end
  end
end
