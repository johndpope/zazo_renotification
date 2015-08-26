class Renotification
  def self.execute
    programs = Program.active
    WriteLog.info self, "Was executed at #{Time.now} for #{programs.size} program(s)."
    programs.each { |program| program.execute }
  end
end
