require_relative "../../persistence/fetch"

RSpec.describe Persistence::Fetch do
  subject(:fetch) { described_class.new(file: "spec/todos.md") }
  before do
    File.open("spec/todos.md", "w") do |f|
      f.write "- [ ] Go Trout Fishing\n"
      f.write "- [x] Buy Mayonnaise\n"
    end
  end
  after { File.delete("spec/todos.md") }

  describe "#all" do
    it "returns all of the stored todos as an array of Todos" do
      expect(fetch.all.map(&:class).uniq).to eq [Todo]
    end

    it "returns the right mappings for each Todo" do
      expect(fetch.all.map { |todo| [todo.label, todo.completed?] }).to eq(
        [
          ["Go Trout Fishing", false],
          ["Buy Mayonnaise", true]

        ]
      )
    end
  end
end
