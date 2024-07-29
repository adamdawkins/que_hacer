require "spec_helper"
require_relative "../../core/todo"
require_relative "../../core/todos_repository"

RSpec.describe TodosRepository do
  describe "#add" do
    it "adds a new todo to the todos with the label and returns them all" do
      todos = [Todo.new(label: "Buy Milk"), Todo.new(label: "Buy Eggs")]

      repository = described_class.new(todos)
      expect(repository.add("Go trout fishing").map(&:label)).to eq(
        ["Buy Milk", "Buy Eggs", "Go trout fishing"]
      )
    end
  end
end
