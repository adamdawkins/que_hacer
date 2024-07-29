require_relative "../../persistence/todo_mappings"

RSpec.describe Persistence::TodoMappings do
  describe ".to_markdown" do
    it "represents an incomplete todo in markdown" do
      todo = Todo.new(label: "Buy Milk", completed: false)
      expect(described_class.to_markdown(todo)).to eq "- [ ] Buy Milk"
    end
    it "represents a completed todo in markdown" do
      todo = Todo.new(label: "Buy Cheese", completed: true)
      expect(described_class.to_markdown(todo)).to eq "- [x] Buy Cheese"
    end
  end

  describe ".to_value" do
    it "returns a Todo with the label and completed attributes"
  end
end
