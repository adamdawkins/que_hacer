require_relative "../core/todo"

module Persistence
  class Save
    def initialize(file: "./todos.md")
      @file = file
    end

    def call(todos)
      File.open(@file, "w") do |f|
        todos.each do |todo|
          f.write "- [ ] #{todo.label}\n"
        end
      end
    end
  end
end
