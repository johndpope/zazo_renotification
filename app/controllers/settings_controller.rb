class SettingsController < ApplicationController
  def index
  end

  def update
    setting = Setting.find params[:id]
    setting.update setting_params
    if setting.save
      redirect_to settings_path
    else
      render :index
    end
  end

  private

  def setting_params
    [:invite_setting, :notification_setting].each do |type|
      return params.require(type).permit(:started) if params.has_key? type
    end
  end
end
