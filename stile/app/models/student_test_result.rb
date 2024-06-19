class StudentTestResult < ApplicationRecord
  belongs_to :student_test_result_set

  validates :student_number,
            :test_id,
            :marks_available,
            :marks_obtained,
            :scanned_on,
            presence: true

  def marks_percentage
    (marks_obtained.to_f / marks_available.to_f) * 100
  end
end
