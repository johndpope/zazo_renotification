class DashboardController < ApplicationController
  def index
    @program_id = params['metrics_by_program']
    @metrics = [
      Metric::VerifiedAfterNthNotification,
      Metric::MessagesByDays
    ]
  end
end
