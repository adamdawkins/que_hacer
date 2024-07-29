require_relative "../core/todo"

module Persistence
  class Save
    def initialize(file: "./todos.md")
      @file = file
    end

    def call(todos)
      File.open(@file, "w") do |f|
        todos.each do |todo|
          completed = todo.completed? ? "x" : " "
          f.write "- [#{completed}] #{todo.label}\n"
        end
      end
    end
  end
end
