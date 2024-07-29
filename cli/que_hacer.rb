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

      register "version", Version, aliases: ["v", "-v", "--version"]
    end
  end
end
Dry::CLI.new(QueHacer::CLI::Commands).call
