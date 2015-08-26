class SettingsController < ApplicationController
  def update
    setting = Setting.find params[:id]
    setting.update! setting_params
    redirect_with_notice setting.program, :settings
  end

  def queries
    manager = Manage::Queries.new queries_params
    if manager.update
      redirect_with_notice manager.program, :queries
    else
      redirect_to options_program_path(manager.program), alert: manager.error
    end
  end

  def conditions
    manager = Manage::Conditions.new conditions_params
    manager.update
    redirect_with_notice manager.program, :conditions
  end

  private

  def setting_params
    params.require(:setting).permit(:started, :use_localized, :include_old_users)
  end

  def queries_params
    res = { program: Program.find(params[:queries]['program_id']),
            queries: params[:queries]['query'].delete_if(&:empty?),
            params: {} }
    res[:queries].each { |q| res[:params][q] = params[:queries][q] }
    res
  end

  def conditions_params
    { program: Program.find(params[:conditions]['program_id']),
      conditions: params[:conditions]['condition'].delete_if(&:empty?) }
  end

  def redirect_with_notice(program, type)
    notice = { notice: "#{type.to_s.capitalize} was successfully updated" }
    redirect_to options_program_path(program), notice
  end
end
