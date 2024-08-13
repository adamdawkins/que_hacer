#!/usr/bin/env ruby
require "bundler/setup"
require "dry/cli"

require_relative "../core/todos_repository"
require_relative "../core/actions/todos/complete"
require_relative "../persistence/fetch"
require_relative "../persistence/save"

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
            todos = Persistence::Fetch.new.all
            if todos.empty?
              puts "Empty list"
            else
              todos.each_with_index do |todo, index|
                puts "#{index}: #{todo.label}"
              end
            end
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
            @todos.each do |todo|
              puts "- [ ] #{todo.label}"
            end
          end
        end

        class Complete < Dry::CLI::Command
          desc "Completes a todo"
          argument :id, required: true, desc: "The number of the todo you want to complete"

          example [
            "0"
          ]

          def call(id:, **)
            @todos ||= TodosRepository.new(Persistence::Fetch.new.all).all
            @todos = @todos.each_with_index.map do |todo, index|
              if index == id.to_i
                Actions::Todos::Complete.call(todo)
              else
                todo
              end
            end

            Persistence::Save.new.call(@todos)

            @todos.each do |todo, index|
              puts "#{index} - [#{todo.completed? ? 'x' : ' '}] #{todo.label}"
            end
          end
        end
      end

      register "version", Version, aliases: ["v", "-v", "--version"]

      register "items", aliases: ["i"] do |prefix|
        prefix.register "list", Items::List
        prefix.register "count", Items::Count
        prefix.register "add", Items::Add
        prefix.register "complete", Items::Complete
      end
    end
  end
end
Dry::CLI.new(QueHacer::CLI::Commands).call
