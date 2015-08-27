class MailingsController < ApplicationController
  def index

  end

  def new
    @form = MailingForm.new
  end

  def run
    manager = Manage::Mailings.new params
    if manager.run
      redirect_to mailings_path
    else
      @form = manager.form
      render :new
    end
  end
end
