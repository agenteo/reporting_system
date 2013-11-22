module ReportingSystem

  class CompletionRate
    attr_reader :jobs

    def initialize(jobs)
      @jobs = jobs
      @completed_jobs_ids = []
    end

    def above?(percentage_of_success)
      started_jobs.each do |started_job|

        finished_jobs.each do |finished_job|
          policy = CompletionPolicy.new(started_job, finished_job)
          if policy.valid?
            @completed_jobs_ids << started_job.job_id
          end
        end
      end

      completion_rate = (@completed_jobs_ids.size * 100) / total_completed_count
      completion_rate >= percentage_of_success
    end

    private

      def total_completed_count
        started_jobs.size
      end

      def started_jobs
        @started_jobs ||= @jobs.select { |job| job.action == :start }
      end

      def finished_jobs
        @jobs.select { |job| job.action == :finish }
      end
  end
  
end
