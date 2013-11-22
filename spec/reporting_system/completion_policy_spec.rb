require 'spec_helper'

module ReportingSystem

  describe CompletionPolicy do
  
    describe ".valid?" do
      context "with a started job" do

        context "with no finished job" do
          let(:start) { Time.local(2008, 9, 1, 12, 0, 0) }
          let(:start_job) { double('Message', job_id: 1, timestamp: start) }
          let(:complete_job) { double('Message', job_id: 4, timestamp: 'ignored') }

          it "should be false" do
            policy = CompletionPolicy.new(start_job, complete_job)
            policy.should_not be_valid
          end
        end

        context "with a finished job within one hour" do
          let(:start) { Time.local(2008, 9, 1, 12, 0, 0) }
          let(:complete) { Time.local(2008, 9, 1, 13, 0, 0) }
          let(:start_job) { double('Message', job_id: 1, timestamp: start) }
          let(:complete_job) { double('Message', job_id: 1, timestamp: complete) }

          it "should be true" do
            policy = CompletionPolicy.new(start_job, complete_job)
            policy.should be_valid
          end
        end

        context "with a finished job within five hours" do
          let(:start) { Time.local(2008, 9, 1, 12, 0, 0) }
          let(:complete) { Time.local(2008, 9, 1, 17, 0, 0) }
          let(:start_job) { double('Message', job_id: 1, timestamp: start) }
          let(:complete_job) { double('Message', job_id: 1, timestamp: complete) }

          it "should be true" do
            policy = CompletionPolicy.new(start_job, complete_job)
            policy.should be_valid
          end
        end

        context "with a finished job after six hours" do
          let(:start) { Time.local(2008, 9, 1, 12, 0, 0) }
          let(:complete) { Time.local(2008, 9, 1, 18, 0, 0) }
          let(:start_job) { double('Message', job_id: 1, timestamp: start) }
          let(:complete_job) { double('Message', job_id: 1, timestamp: complete) }

          it "should be false" do
            policy = CompletionPolicy.new(start_job, complete_job)
            policy.should_not be_valid
          end
        end
      end
    end

  end
end
