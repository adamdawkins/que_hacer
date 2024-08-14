require "spec_helper"
require_relative "../../core/todos_repository"

RSpec.describe TodosRepository do
  subject(:repository) { described_class.new(todos) }
  let(:todos) { [Todo.new(label: "Buy Milk"), Todo.new(label: "Buy Eggs")] }
  describe "#add" do
    it "adds a new todo to the todos with the label and returns them all" do
      expect(repository.add("Go trout fishing").map(&:label)).to eq(
        ["Buy Milk", "Buy Eggs", "Go trout fishing"]
      )
    end
  end

  describe "#all" do
    it "returns the todos" do
      expect(repository.all).to eq todos
    end
  end

  describe "#remove" do
    it "returns all todos except the todo at the index of the removed todo" do
      expect(repository.remove(1).map(&:label)).to eq ["Buy Milk"]
    end
  end

  describe "#complete" do
    it "marks the todo at the index as complete" do
      expect(repository.complete(1).map { |todo| [todo.label, todo.completed?] }).to eq(
        [["Buy Milk", false],
         ["Buy Eggs", true]]
      )
    end
  end

  describe "#complete_all" do
    it "marks all todos as completed" do
      expect(repository.complete_all).to all be_completed
    end
  end

  describe "#clear_completed" do
    let(:todos) do
      [Todo.new(label: "Buy Milk"), Todo.new(label: "Buy Eggs", completed: false),
       Todo.new(label: "Buy Cheese", completed: true), Todo.new(label: "Buy Bread", completed: true)]
    end
    it "returns the todos without the completed ones" do
      expect(repository.clear_completed.map(&:label)).to eq ["Buy Milk", "Buy Eggs"]
    end
  end

  describe "#count_active" do
    let(:todos) do
      [Todo.new(label: "Buy Milk"), Todo.new(label: "Buy Eggs", completed: false),
       Todo.new(label: "Buy Milk", completed: true), Todo.new(label: "Buy Bread", completed: true)]
    end
    it "returns the number of todos that are not complete" do
      expect(repository.count_active).to eq 2
    end
  end
end
