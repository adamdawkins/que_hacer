require_relative "../../core/todo"

RSpec.describe Todo do
  describe "initializing" do
    it "sets the label to a method" do
      todo = described_class.new(label: "Mayonnaise")
      expect(todo.label).to eq "Mayonnaise"
    end

    it "errors without a label" do
      expect { described_class.new }.to raise_error ArgumentError
    end

    it "sets 'completed' to false" do
      todo = described_class.new(label: "Mayonnaise")
      expect(todo.completed?).to be false
    end
  end
end
