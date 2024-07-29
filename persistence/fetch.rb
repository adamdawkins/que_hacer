require_relative "../core/todo"
require_relative "todo_mappings"

module Persistence
  class Fetch
    def initialize(file: "./todos.md")
      @file = File.open(file)
    end

    def all
      @file.readlines.map(&:chomp).map { |line| TodoMappings.to_value(line) }
    end
  end
end
