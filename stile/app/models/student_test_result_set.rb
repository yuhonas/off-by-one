class StudentTestResultSet < ApplicationRecord
  has_many :student_test_results, dependent: :destroy

  validates :request_id, :xml_data, presence: true
end
