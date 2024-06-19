require 'rails_helper'

RSpec.describe 'StudentTestResults', type: :request do
  describe 'POST /import' do
    let(:xml_file) { fixture_file_upload('student_test_results.xml') }

    it 'should create a record and returns the appropriate response code' do
      expect do
        post '/import', params: { xml: xml_file }, headers: { 'ACCEPT': 'text/xml+markr' }
      end.to change(StudentTestResult, :count).by(1)

      expect(response).to have_http_status(:success)
    end

    context 'should create multiple records and returns the appropriate response code' do
      let(:xml_file) { fixture_file_upload('student_test_results_multi.xml') }
      it 'returns http success' do
        expect do
          post '/import', params: { xml: xml_file }, headers: { 'ACCEPT': 'text/xml+markr' }
        end.to change(StudentTestResult, :count).by(3)

        expect(response).to have_http_status(:success)
      end

      it 'should only process markr results' do
        expect do
          post '/import', params: { xml: xml_file }, headers: { 'ACCEPT': 'text/xml' }
        end.to change(StudentTestResult, :count).by(0)

        expect(response).to have_http_status(406)
      end

      context 'invalid records' do
        let(:xml_file) { fixture_file_upload('student_test_results_invalid.xml') }
        it 'should not save any records irrespective of if there is valid ones' do
          expect do
            post '/import', params: { xml: xml_file }, headers: { 'ACCEPT': 'text/xml+markr' }
          end.to change(StudentTestResult, :count).by(0)

          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
