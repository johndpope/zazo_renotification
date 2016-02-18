class MetricsController < ApplicationController
  def index
    @program_id = params['metrics_by_program']
    @metrics = [Metric::VerifiedAfterNthNotification]
  end
end
