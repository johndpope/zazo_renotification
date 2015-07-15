class Condition::Check
  attr_reader :user, :program

  def initialize(user, program)
    @user    = user
    @program = program
  end

  def do
    program.conditions.each { |c| return false unless c.check user }
    program.setting.started
  end
end
