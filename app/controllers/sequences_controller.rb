class SequencesController < ApplicationController
  before_action :set_sequence, only: [:sms, :email, :ios, :android]

  def index
  end

  def create
  end

  def sms
    edit_by_type :sms
  end

  def email
    edit_by_type :email
  end

  def ios
    edit_by_type :ios
  end

  def android
    edit_by_type :android
  end

  private

  def set_sequence
    @sequence = Sequence.new
  end

  def edit_by_type(type)
    @templates = Template.by_type type
    @sequences = Sequence.by_template_type type
    @sequence.type = type
    render 'edit'
  end
end
