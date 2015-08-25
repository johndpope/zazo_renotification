class Templates::LocalizedTemplatesController < ApplicationController
  before_action :set_template
  before_action :set_localized_template, only: [:edit, :update, :destroy]

  def new
    @localized = LocalizedTemplate.new
  end

  def edit
  end

  def create
    if service.create
      redirect_to templates_url, notice: "Localized template for #{@template.name} was successfully created"
    else
      @localized = service.model
      render :new
    end
  end

  def update
    if service.update
      redirect_to templates_url, notice: "Localized template for #{@template.name} was successfully updated"
    else
      @localized = service.model
      render :edit
    end
  end

  def destroy
    @localized.destroy
    redirect_to templates_url
  end

  private

  def service
    @service ||= Manage::LocalizedTemplates.new({
      parent: @template,
      model:  @localized,
      params: localized_template_params
    })
  end

  def set_template
    @template = Template.find params[:template_id]
  end

  def set_localized_template
    @localized = LocalizedTemplate.find params[:id]
  end

  def localized_template_params
    params.require(:localized_template).permit(:locale, :title, :body)
  end
end
