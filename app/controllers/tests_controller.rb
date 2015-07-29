class TestsController < ApplicationController
  before_action :set_program
  before_action :set_test_data

  def run
    Program::Test.new(@program, @test_data).send params[:id]
    redirect_to programs_path
  end

  private

  def set_program
    @program = Program.find params[:program_id]
  end
end
