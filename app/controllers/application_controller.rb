class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with name:     Figaro.env.http_basic_username,
                               password: Figaro.env.http_basic_password

  protected

  def set_test_data
    @test_data = {
      phone: session[:test_phone] || APP_INFO['test_phone'],
      email: session[:test_email] || APP_INFO['test_email']
    }
  end
end
