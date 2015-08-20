class Templates::LocalizedController < ApplicationController
  before_action :set_template
  before_action :set_localized_template

  def new
  end

  def edit
  end

  def create
    if service.create
      redirect_to templates_url, notice: "Localized template for #{@template.name} was successfully created"
    else
      render :new
    end
  end

  def update
    if service.update
      redirect_to templates_url, notice: "Localized template for #{@template.name} was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @localized.destroy
    redirect_to templates_url
  end

  private

  def service
    Manage::LocalizedTemplate.new @localized, localized_template_params
  end

  def set_template
    @template = Template.find params[:template_id]
  end

  def set_localized_template
    @localized = if params[:id]
      LocalizedTemplate.find params[:id]
    else
      LocalizedTemplate.new
    end
  end

  def localized_template_params
    params.require(:localized_template).permit(:locale, :title, :body)
  end
end
