class SequencesController < ApplicationController
  before_action :set_program

  def create
    @sequence = Sequence.new sequence_params
    @sequence.program = @program

    if @sequence.save
      redirect_to program_sequences_path(@program) + "/#{@sequence.type}"
    else
      edit_by_type @sequence.type
    end
  end

  def destroy
    Sequence.find(params[:id]).destroy
    if session[:last_type]
      edit_by_type session[:last_type]
    else
      redirect_to program_sequences_path @program
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

  def set_program
    @program = Program.find params[:program_id]
  end

  def edit_by_type(type)
    session[:last_type] = type
    @sequence ||= Sequence.new
    @sequence.type    = type
    @sequence.program = @program
    render 'edit'
  end

  def sequence_params
    params.require(:sequence).permit(:type, :template_id, :delay_hours)
  end
end
