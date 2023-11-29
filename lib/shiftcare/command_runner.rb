# frozen_string_literal: true

module Shiftcare
  # command line options dispatcher
  class CommandRunner
    def initialize(explorer)
      @explorer = explorer
    end

    # will noop if no options are passed
    def run(options)
      if options[:search]
        @explorer.search(options[:search])
      elsif options[:duplicates]
        @explorer.duplicates
      end
    end
  end
end
