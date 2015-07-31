class SettingsController < ApplicationController
  def update
    setting = Setting.find params[:id]
    setting.update! setting_params
    redirect_to options_program_path(setting.program), notice(:settings)
  end

  def queries
    manager = Manage::Queries.new queries_params
    manager.update
    redirect_to options_program_path(manager.program), notice(:queries)
  end

  def conditions
    manager = Manage::Conditions.new conditions_params
    manager.update
    redirect_to options_program_path(manager.program), notice(:conditions)
  end

  private

  def setting_params
    params.require(:setting).permit(:started)
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

  def notice(type)
    { notice: "#{type.to_s.capitalize} was successfully updated" }
  end
end
