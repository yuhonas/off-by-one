module Shiftcare
  class NaiveEngine
    attr_accessor :data

    def initialize(data)
      self.data = data
    end

    # perform a simple case insenstive substring search for the first matching record
    def search(keyword)
      data.each do |record|
        return record if record["full_name"].downcase.include?(keyword.downcase)
      end

      {}
    end

    # find duplicated records by email
    def duplicates
      data.group_by { |record| record["email"] }.select { |_, v| v.size > 1 }.values.flatten
    end
  end
end
