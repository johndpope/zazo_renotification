class MailingsController < ApplicationController
  def index
    @entries = Mailing.all
  end

  def show
    @entries = Mailing.by_key params[:id]
  end

  def new
    @form = MailingForm.new
  end

  def run
    if manager.run
      redirect_to mailings_path
    else
      @form = manager.form
      render :new
    end
  end

  private

  def manager
    @manager ||= Manage::Mailings.new params
  end
end
