class QueriesController < ApplicationController
  def index
    @queries = Query.nested
  end

  def show
    @query = params[:id].constantize
  end
end
