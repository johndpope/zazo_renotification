class Renotification
  def self.execute
    programs = Program.active
    Rails.logger.tagged('Renotification') { Rails.logger.debug "Was executed at #{Time.now} for #{programs.size} program(s)." }
    programs.each { |prg| Program::Execute.new(prg).do }
  end
end
