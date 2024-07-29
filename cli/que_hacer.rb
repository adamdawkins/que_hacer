#!/usr/bin/env ruby
require "bundler/setup"
require "dry/cli"

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
      end

      register "version", Version, aliases: ["v", "-v", "--version"]

      register "items", aliases: ["i"] do |prefix|
        prefix.register "list", Items::List
      end
    end
  end
end
Dry::CLI.new(QueHacer::CLI::Commands).call
