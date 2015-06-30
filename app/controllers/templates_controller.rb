class TemplatesController < ApplicationController
  before_action :set_template, only: [:edit, :update, :destroy]

  def index
    @templates = Template.all
  end

  def new
    @template = Template.new
  end

  def edit
  end

  def create
    @template = Template.new(template_params)

    if @template.save
      redirect_to templates_url
    else
      render :new
    end
  end

  def update
    if @template.update(template_params)
      redirect_to edit_template_path
    else
      render :edit
    end
  end

  def destroy
    @template.destroy
    redirect_to templates_url
  end

  private

  def set_template
    @template = Template.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:kind, :name, :title, :body)
  end
end
