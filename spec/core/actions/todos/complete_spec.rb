require_relative "../../../../core/todo"
require_relative "../../../../core/actions/todos/complete"

RSpec.describe Actions::Todos::Complete do
  describe ".call" do
    let(:todo) { Todo.new(label: "Comprar queso", completed: false) }
    it "returns a completed todo with the same label as the original" do
      new_todo = described_class.call(todo)
      expect([new_todo.label, new_todo.completed?]).to eq ["Comprar queso", true]
    end
  end
end
