#!/usr/bin/env ruby
require "bundler/setup"
require "dry/cli"

require_relative "../core/todos_repository"
require_relative "../persistence/fetch"
require_relative "../persistence/save"

class Renderer
  def self.list(todos)
    if todos.empty?
      puts "No todos"
    else
      todos.each_with_index do |todo, index|
        puts "#{index} - [#{todo.completed? ? 'x' : ' '}] #{todo.label}"
      end
    end
  end
end

module QueHacer
  module CLI
    module Commands
      extend Dry::CLI::Registry

      class Version < Dry::CLI::Command
        desc "Print version"

        def call(*)
          puts "0.0.1"
        end
      end

      module Items
        class List < Dry::CLI::Command
          desc "Lists items"

          def call(*)
            todos = TodosRepository.new(Persistence::Fetch.new.all).all
            Renderer.list(todos)
          end
        end

        class Count < Dry::CLI::Command
          desc "Counts active items"
          def call(*)
            count = TodosRepository.new(Persistence::Fetch.new.all).count_active
            puts "#{count} active item#{count == 1 ? '' : 's'}"
          end
        end

        class Add < Dry::CLI::Command
          desc "Adds a Todo"
          argument :label, required: true, desc: "The description of the todo"

          example [
            "'Go Fishing'"
          ]

          def call(label:, **)
            @todos ||= TodosRepository.new(Persistence::Fetch.new.all)
            @todos = @todos.add(label)
            Persistence::Save.new.call(@todos)
            Renderer.list(@todos)
          end
        end

        class Edit < Dry::CLI::Command
          desc "renames a todo"
          argument :id, required: true, desc: "The number of the todo you want to complete"
          argument :label, required: true, desc: "The description of the todo"

          example [
            "1 'Go Trout Fishing'"
          ]

          def call(id:, label:, **)
            @todos = TodosRepository.new(Persistence::Fetch.new.all).update(id.to_i, label)
            Persistence::Save.new.call(@todos)
            Renderer.list(@todos)
          end
        end

        class CompleteAll < Dry::CLI::Command
          desc "Marks all todos as completed"

          def call(*)
            @todos = TodosRepository.new(Persistence::Fetch.new.all).complete_all
            Persistence::Save.new.call(@todos)

            Renderer.list(@todos)
          end
        end

        class Complete < Dry::CLI::Command
          desc "Completes a todo"
          argument :id, required: true, desc: "The number of the todo you want to complete"

          example [
            "0"
          ]

          def call(id:, **)
            @todos ||= TodosRepository.new(Persistence::Fetch.new.all).complete(id.to_i)
            Persistence::Save.new.call(@todos)

            Renderer.list(@todos)
          end
        end

        class Remove < Dry::CLI::Command
          desc "Removes a todo"
          argument :id, required: true, desc: "The number of the todo you want to complete"

          example [
            "0"
          ]

          def call(id:, **)
            @todos ||= TodosRepository.new(Persistence::Fetch.new.all).remove(id.to_i)
            Persistence::Save.new.call(@todos)

            Renderer.list(@todos)
          end
        end

        class ClearCompleted < Dry::CLI::Command
          desc "deletes completed todos"
          def call(*)
            @todos ||= TodosRepository.new(Persistence::Fetch.new.all).clear_completed
            Persistence::Save.new.call(@todos)

            Renderer.list(@todos)
          end
        end
      end

      register "items", aliases: ["i"] do |prefix|
        prefix.register "add", Items::Add
        prefix.register "clear", Items::ClearCompleted
        prefix.register "complete", Items::Complete
        prefix.register "complete_all", Items::CompleteAll
        prefix.register "count", Items::Count
        prefix.register "list", Items::List
        prefix.register "remove", Items::Remove
        prefix.register "edit", Items::Edit
      end

      register "version", Version, aliases: ["v", "-v", "--version"]
    end
  end
end
Dry::CLI.new(QueHacer::CLI::Commands).call
