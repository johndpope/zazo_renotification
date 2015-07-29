class SessionsController < ApplicationController
  before_action :set_test_data, only: :index

  def index
  end

  def create
    session[:test_phone] = params[:session][:test_phone]
    session[:test_email] = params[:session][:test_email]
    redirect_to programs_path, notice: 'Session variables was successfully updated'
  end

  def reset
    session.delete :test_phone
    session.delete :test_email
    redirect_to sessions_path
  end
end
