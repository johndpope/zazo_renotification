class Renotification
  def self.execute
    MessageWorker.perform_in 20.seconds, 'zazo'
  end
end
