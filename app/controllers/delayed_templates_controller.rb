class DelayedTemplatesController < ApplicationController
  before_action :set_program

  def create
    @delayed_template = DelayedTemplate.new delayed_template_params
    @delayed_template.program = @program

    if @delayed_template.save
      redirect_to_program @delayed_template.type
    else
      edit_by_type @delayed_template.type
    end
  end

  def destroy
    DelayedTemplate.find(params[:id]).destroy
    if session[:last_type]
      redirect_to_program session[:last_type]
    else
      redirect_to_program
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

  def redirect_to_program(type = nil)
    if type.nil?
      redirect_to program_delayed_templates_path @program
    else
      redirect_to program_delayed_templates_path(@program) + "/#{type}"
    end
  end

  def edit_by_type(type)
    session[:last_type] = type
    @delayed_template ||= DelayedTemplate.new
    @delayed_template.type    = type
    @delayed_template.program = @program
    render 'edit'
  end

  def delayed_template_params
    params.require(:delayed_template).permit(:type, :template_id, :delay_hours)
  end
end
