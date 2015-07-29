class SessionsController < ApplicationController
  def index
    @test_data = {
      phone: session[:test_phone] || APP_INFO['test_phone'],
      email: session[:test_email] || APP_INFO['test_email']
    }
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
