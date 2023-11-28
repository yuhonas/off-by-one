# Parse options
module Shiftcare
  class NaiveEngine
    attr_accessor :data

    def initialize(data)
      self.data = data
    end

    # deal with multiple matches
    # case insensitive
    # return the first match
    # implement default keyword argument
    def search(keyword)
      data.each do |record|
        return record if record["full_name"].downcase.include?(keyword.downcase)
      end

      {}
    end

    def duplicates
      # find duplicated records with the full_name key in the data array
      # return an array of the duplicated records
      data.group_by { |record| record["email"] }.select { |_, v| v.size > 1 }.values.flatten
    end
  end
end
