require 'rails_helper'

RSpec.describe 'Reports', type: :request do
  describe 'GET /aggregate' do
    subject(:json) { JSON.parse(response.body).with_indifferent_access }

    it 'returns the correct values for a single test submission' do
      result = create(:student_test_result, marks_available: 20, marks_obtained: 13)

      get "/reports/#{result.test_id}/aggregate"
      expect(response).to have_http_status(:success)

      expect(json).to include(
        {
          "mean": 65.0,
          "stddev": 0.0,
          "min": 65.0,
          "max": 65.0,
          "p25": 65.0,
          "p50": 65.0,
          "p75": 65.0,
          "count": 1
        }
      )
    end

    it 'takes the higher marks_available if two results have the same student_id' do
      create(:student_test_result, \
             test_id: 1, \
             student_number: 5, \
             marks_available: 7, \
             marks_obtained: 13)

      create(:student_test_result, \
             test_id: 1, \
             student_number: 5, \
             marks_available: 20, \
             marks_obtained: 13)

      get '/reports/1/aggregate'
      expect(json).to include(
        {
          "mean": 65.0,
          "stddev": 0.0,
          "min": 65.0,
          "max": 65.0,
          "p25": 65.0,
          "p50": 65.0,
          "p75": 65.0,
          "count": 1
        }
      )
      expect(response).to have_http_status(:success)
    end

    # NOTE: There will be an order of precedence here
    it 'takes the higher marks_obtained if two results have the same student_id' do
    end

    it 'handles a multiple result for a single student' do
      result = create(:student_test_result, marks_available: 20, marks_obtained: 13)

      get "/reports/#{result.test_id}/aggregate"
      expect(response).to have_http_status(:success)
    end

    xit 'handles multiple results for multiple students' do
      get "/reports/#{result.test_id}/aggregate"
      expect(response).to have_http_status(:success)
    end

    xit 'takes the highest result if there is duplicates for the same test id' do
      get "/reports/#{result.test_id}/aggregate"
      expect(response).to have_http_status(:success)
    end
  end
end
