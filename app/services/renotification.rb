class Renotification
  def self.execute
    Program.active.each { |p| Program::Execute.new(p).do }
  end
end
