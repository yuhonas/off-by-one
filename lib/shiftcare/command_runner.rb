# frozen_string_literal: true

module Shiftcare
  # command line options dispatcher
  class CommandRunner
    def initialize(engine)
      @engine = engine
    end

    def run(options)
      if options[:search]
        @engine.search(options[:search])
      elsif options[:duplicates]
        @engine.duplicates
      end
    end
  end
end
