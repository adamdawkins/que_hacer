#!/usr/bin/env ruby
require "bundler/setup"
require "dry/cli"

require_relative "../core/todos_repository"

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
            todos = []
            if todos.empty?
              puts "Empty list"
            else
              todos.each do |todo|
                puts todo
              end
            end
          end
        end

        class Add < Dry::CLI::Command
          desc "Adds a Todo"
          argument :label, required: true, desc: "The description of the todo"

          example [
            "'Go Fishing'"
          ]

          def call(label:, **)
            todos = TodosRepository.new([])
            todos = todos.add(label)
            todos.each do |todo|
              puts "- [ ] #{todo.label}"
            end
          end
        end
      end

      register "version", Version, aliases: ["v", "-v", "--version"]

      register "items", aliases: ["i"] do |prefix|
        prefix.register "list", Items::List
        prefix.register "add", Items::Add
      end
    end
  end
end
Dry::CLI.new(QueHacer::CLI::Commands).call
