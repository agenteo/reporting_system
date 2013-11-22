module ReportingSystem

  class CompletionPolicy
    COMPLETION_THRESHOLD = 300 # minutes

    def initialize(start_message, complete_message)
      @start_message, @complete_message = start_message, complete_message
    end

    def valid?
      if start_message_completed?
        return completed_after_minutes <= COMPLETION_THRESHOLD
      end
      false
    end

    private

      def start_message_completed?
        @start_message.job_id == @complete_message.job_id
      end

      def completed_after_minutes
        (@complete_message.timestamp - @start_message.timestamp) / 60
      end
  end

end
