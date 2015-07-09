class ProgramsController < ApplicationController
  before_action :set_program, only: [:users, :options, :edit, :update, :destroy]

  def index
    @programs = Program.order_by_updated_at
  end

  def users
    @users = Query::Intersection.new(@program.queries).results
  end

  def options
  end

  def new
    @program = Program.new
  end

  def edit
  end

  def create
    @program = Program.new program_params
    @program.setting

    if @program.save
      redirect_to programs_url
    else
      render :new
    end
  end

  def update
    if @program.update program_params
      redirect_to programs_url
    else
      render :edit
    end
  end

  def destroy
    @program.destroy
    redirect_to programs_url
  rescue ActiveRecord::InvalidForeignKey
    flash[:alert] = 'Program has dependencies'
    redirect_to programs_url
  end

  private

  def set_program
    @program = Program.find params[:id]
  end

  def program_params
    params.require(:program).permit(:name)
  end
end
