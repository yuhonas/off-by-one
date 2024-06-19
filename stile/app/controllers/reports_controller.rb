class ReportsController < ApplicationController
  def aggregate
    # OPTIMIZE: This far from optimal, having to scan through all the students records to find the "valid" ones
    # then calculating the percentage for each one, this is simply a first pass and would be great to discuss
    # Some options to optimize could be a materialized view, or a cache (application, CDN), a more performant query or
    # simply having the data model's in a more querable state for this type of reporting
    # We either do the work up front, do it later, or do it less often with caching
    # Performance will be O(n) for the size of the result set

    results = StudentTestResult.where(test_id: params[:test_id])
                               .select('student_number, MAX(marks_obtained) as marks_obtained, MAX(marks_available) as marks_available')
                               .group(:student_number)
                               .map { |result| result.marks_percentage }

    # NOTE: Will return 0 even for test_id's that do not exist
    # Rather then returning 404

    # OPTIMIZE: I'm unsure of how computationally expensive the number manipulation is particulary
    report = if results.empty?
               {
                 "count": 0,
                 "max": 0,
                 "mean": 0,
                 "min": 0,
                 "p25": 0,
                 "p50": 0,
                 "p75": 0,
                 "stddev": 0
               }
             else
               {
                 "count": results.size,
                 "max": results.max,
                 "mean": results.mean,
                 "min": results.min,
                 "p25": results.percentile(25),
                 "p50": results.percentile(50),
                 "p75": results.percentile(75),
                 "stddev": results.many? ? results.stdev : 0
               }
             end

    render json: report
  end
end
