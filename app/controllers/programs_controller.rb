class ProgramsController < ApplicationController
  before_action :set_program, only: [:edit, :update, :destroy]

  def index
    @programs = Program.all
  end

  def new
    @program = Program.new
  end

  def edit
  end

  def create
    @program = Program.new program_params

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

  end

  private

  def set_program
    @program = Program.find params[:id]
  end

  def program_params
    params.require(:program).permit(:name)
  end
end
