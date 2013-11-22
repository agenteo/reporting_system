require 'spec_helper'
include MessageHelpers

module ReportingSystem

  describe CompletionRate do
    describe ".above(percentage)", focused_integration: true do
      let(:percentage) { 50 }

      before do
        @jobs = []
        total_completed.times { |job_id| @jobs += completed_job(job_id) }
        total_incompleted.times { |job_id| @jobs += incompleted_job(job_id + 10) }
      end

      context "with 6 out of 10 jobs completed" do
        let(:total_completed) { 6 }
        let(:total_incompleted) { 4 }

        it "should be true" do
          completion_rate = CompletionRate.new(@jobs)
          completion_rate.should be_above(50)
        end
      end

      context "with 5 out of 10 jobs completed" do
        let(:total_completed) { 5 }
        let(:total_incompleted) { 5 }

        it "should be true" do
          completion_rate = CompletionRate.new(@jobs)
          completion_rate.should be_above(50)
        end
      end

      context "with 4 out of 10 jobs completed" do
        context "within the time threshold" do
          let(:total_completed) { 4 }
          let(:total_incompleted) { 6 }

          it "should be false" do
            completion_rate = CompletionRate.new(@jobs)
            completion_rate.should_not be_above(50)
          end
        end

        context "not within the time threshold" do
          let(:total_completed) { 1 }
          let(:total_incompleted) { 0 }
          before do
            @jobs = []
            total_completed.times do |job_id|
              @jobs << double('Message', job_id: job_id, action: :start, timestamp: Time.now)
              six_hours_later = 360 * 60
              Timecop.freeze(six_hours_later) do
                @jobs << double('Message', job_id: job_id, action: :finish, timestamp: Time.now)
              end
            end
            total_incompleted.times { |job_id| @jobs += incompleted_job(job_id + 10) }
          end


          it "should be false" do
            completion_rate = CompletionRate.new(@jobs)
            completion_rate.should_not be_above(50)
          end
        end
      end

    end
  end
end
