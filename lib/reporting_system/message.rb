module ReportingSystem

  class Message
    attr_reader :action, :job_id, :job_name,
                :timestamp

    def initialize(parameters)
      @action = parameters.fetch(:action)
      @job_id = parameters.fetch(:jobId)
      @job_name  = parameters.fetch(:jobName)
      @timestamp = Time.now
    end
    
  end
  
end
