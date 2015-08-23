class WriteLog
  def self.debug(context, message)
    klass_name = context.instance_of?(Class) ? context.name : context.class.name
    Rails.logger.tagged(klass_name) { Rails.logger.info message }
    Rails.syslogger.info("[#{klass_name}] #{message}") if Rails.env.production?
  end

  def self.faraday_error(context, error)
    debug context, "#{e.class} => #{e.response[:body]}"
  end
end
