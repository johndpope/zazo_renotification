module TraceWrapper
  extend NewRelic::Agent::Instrumentation::ControllerInstrumentation

  def self.trace(name)
    perform_action_with_newrelic_trace(name: name, category: :task) { yield }
  end
end
