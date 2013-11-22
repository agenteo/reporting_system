require 'spec_helper'

module ReportingSystem

  describe Listener do

    describe ".add_message" do
      let(:message) { { action: :start, jobId: 77, jobName: 'cleanup' } }

      it "should add an event to the log" do
        listener = Listener.new
        listener.add_message(message)
        listener.log.size.should == 1
      end

    end
  
  end
end
