class SequencesController < ApplicationController
  before_action :set_sequence, only: [:sms, :email, :ios, :android]

  def index
  end

  def create
  end

  def sms
    @sequence.type = :sms
    render 'edit'
  end

  def email
    @sequence.type = :email
    render 'edit'
  end

  def ios
    @sequence.type = :ios
    render 'edit'
  end

  def android
    @sequence.type = :android
    render 'edit'
  end

  private

  def set_sequence
    @sequence = Sequence.new
  end
end
