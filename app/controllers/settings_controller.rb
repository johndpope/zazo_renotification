class SettingsController < ApplicationController
  def update
    setting = Setting.find params[:id]
    setting.update! setting_params
    redirect_to options_program_path setting.program
  end

  def queries
    manager = Manage::Queries.new queries_params
    manager.update
    redirect_to options_program_path manager.program
  end

  def conditions
    manager = Manage::Conditions.new conditions_params
    manager.update
    redirect_to options_program_path manager.program
  end

  private

  def setting_params
    params.require(:setting).permit(:started)
  end

  def queries_params
    { program: Program.find(params[:queries]['program_id']),
      queries: params[:queries]['query'].delete_if(&:empty?) }
  end

  def conditions_params
    { program: Program.find(params[:conditions]['program_id']),
      conditions: params[:conditions]['condition'].delete_if(&:empty?) }
  end
end
