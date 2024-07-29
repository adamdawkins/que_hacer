require_relative "../../persistence/save"

RSpec.describe Persistence::Save do
  before { File.open("spec/todos.md", "w") }
  after { File.delete("spec/todos.md") }

  describe ".call" do
    it "writes the todos into the file in Markdown format" do
      described_class.new(file: "spec/todos.md").call([Todo.new(label: "Buy Milk"),
                                                       Todo.new(label: "Buy Sugar", completed: true)])

      expect(File.readlines("spec/todos.md").map(&:chomp)).to eq([
                                                                   "- [ ] Buy Milk",
                                                                   "- [x] Buy Sugar"
                                                                 ])
    end
  end
end
