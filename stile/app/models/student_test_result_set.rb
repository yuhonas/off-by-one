class StudentTestResultSet < ApplicationRecord
  has_many :student_test_results, dependent: :destroy
end
