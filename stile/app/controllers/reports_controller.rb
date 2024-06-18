class ReportsController < ApplicationController
  def aggregate
    # OPTIMIZE: Although this is a simple query, with larger result sets
    # or frequent requests, we may want to consider pagination, materalized views and/or
    # caching the results at various levels (e.g. database, application, CDN)
    # I'm also unsure of how computationally expensive the number manipulation is
    # which will be O(n) for the size of the result set
    results = StudentTestResult.where(test_id: params[:test_id]).pluck(:marks_percentage)

    # NOTE: Will return 0 even for test_id's that do not exist
    # Rather then returning 404
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
