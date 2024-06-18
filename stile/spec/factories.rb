FactoryBot.define do
  factory :student_test_result do
    student_number { rand(1..5000) }
    test_id { rand(1000..4000) }
    marks_available { rand(1..20) }
    marks_obtained { rand(1..20) }
    xml_data do
      '<mcq-test-result><student-number>521585128</student-number><test-id>1234</test-id><summary-marks available="20" obtained="13"></summary-marks><scanned-on>2017-12-04T12:12:10+11:00</scanned-on></mcq-test-result>'
    end
    scanned_on { 1.day.ago }
  end
end
