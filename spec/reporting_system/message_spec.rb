require 'spec_helper'

module ReportingSystem

  describe Message do

    describe "#new" do
      let(:params) { { action: :start, jobId: 77, jobName: 'cleanup' } }

      it "should assign a time stamp to the message" do
        message = Message.new(params)
        message.timestamp.should_not be_nil
      end
    
    end
  
  end
end
