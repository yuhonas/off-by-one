class StudentTestResult < ApplicationRecord
  before_save :calculate_percentage

  validates :student_number, \
            :test_id, \
            :marks_available, \
            :marks_obtained, \
            :scanned_on,
            presence: true

  private

  def calculate_percentage
    self.marks_percentage = (marks_obtained.to_f / marks_available.to_f) * 100
  end
end
