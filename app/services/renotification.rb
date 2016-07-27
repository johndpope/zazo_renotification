class Renotification
  def self.execute
    programs = Program.active
    Zazo::Tool::Logger.info(self, "executed for #{programs.size} program(s)")
    programs.each { |program| program.execute }
  end
end
