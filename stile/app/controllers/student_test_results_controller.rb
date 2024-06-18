class StudentTestResultsController < ApplicationController
  before_action :ensure_markr_request

  def import
    # FIXME: shouldn't need to check for xml in params but will do for now
    xml = params[:xml]&.read || request.body.read

    # NOTE: I'm assuming that the XML is well-formed and valid (we can discuss what happens when it's not)
    # We should also discuss parser performance/efficiency/tollerance of malformed XML

    # OPTIMIZE: Memory performance will be O(N), there is a potential for a large XML file to
    # consume a lot of memory, we could consider using a SAX parser or a streaming parser
    doc = Nokogiri::XML(xml)

    # NOTE: This is wrapped in a transaction so it's atomic to ensure that if
    # any of the records fail to save, none of them are saved, the rationale being is
    # that I dont want to have to deal with partial data being saved
    # if this DOES fail, the client will get a 422 (the most important thing) however
    # the response body won't be JSON but we should talk further about the DX here
    StudentTestResult.transaction do
      doc.css('mcq-test-result').each do |node|
        # OPTIMIZE: This will result in O(N) INSERT'S and won't be performant for 'large' record
        # sets we could consider using a bulk insert statement such as UPSERT (which would require pre-validation)
        # or something like https://github.com/zdennis/activerecord-import
        StudentTestResult.create!(
          student_number: node.at_css('student-number')&.text,
          test_id: node.at_css('test-id')&.text,
          marks_available: node.at_css('summary-marks')&.[]('available'),
          marks_obtained: node.at_css('summary-marks')&.[]('obtained'),
          xml_data: xml,
          scanned_on: node['scanned-on']
        )
      end
    end

    render status: :ok
  end

  private

  # NOTE: Ensure requests are only accepted if they are of the "markr" format
  # this is a hard stop, and we'd need to be careful here but it's either a 406 or
  # a 422 response at this stage based on what we know, take your pick
  def ensure_markr_request
    return if request.format.markr?

    render status: :not_acceptable
  end
end
