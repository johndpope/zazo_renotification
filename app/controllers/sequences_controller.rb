class SequencesController < ApplicationController
  def index
    @sequences = {}
    (Template::ALLOW_TYPES - ['ios', 'android']).each do |type|
      @sequences[type] = Sequence.by_template_type(type).order_by_delay
    end
  end

  def create
    @sequence = Sequence.new sequence_params

    if @sequence.save
      redirect_to sequences_path + "/#{@sequence.type}"
    else
      edit_by_type @sequence.type
    end
  end

  def destroy
    Sequence.find(params[:id]).destroy
    if session[:last_type]
      edit_by_type session[:last_type]
    else
      redirect_to sequences_path
    end
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

  def edit_by_type(type)
    session[:last_type] = type
    @templates  = Template.by_type type
    @sequences  = Sequence.by_template_type(type).order_by_delay
    @sequence ||= Sequence.new
    @sequence.type = type
    render 'edit'
  end

  def sequence_params
    params.require(:sequence).permit(:type, :template_id, :delay_hours)
  end
end
