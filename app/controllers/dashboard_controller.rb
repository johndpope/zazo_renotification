class DashboardController < ApplicationController
  def index
    @program_id = params['metrics_by_program']
  end
end
