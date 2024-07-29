require_relative "../core/todo"
require_relative "todo_mappings"

module Persistence
  class Save
    def initialize(file: "./todos.md")
      @file = file
    end

    def call(todos)
      File.open(@file, "w") do |f|
        todos.each do |todo|
          f.write "#{TodoMappings.to_markdown(todo)}\n"
        end
      end
    end
  end
end
