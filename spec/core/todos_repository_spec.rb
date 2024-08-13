require "spec_helper"
require_relative "../../core/todos_repository"

RSpec.describe TodosRepository do
  subject(:repository) { described_class.new(todos) }
  let(:todos) { [Todo.new(label: "Buy Milk"), Todo.new(label: "Buy Eggs")] }
  describe "#add" do
    it "adds a new todo to the todos with the label and returns them all" do
      repository = described_class.new(todos)
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
end
