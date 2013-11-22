module ReportingSystem

  class Listener
    attr_reader :log

    def initialize
      @log = []
    end

    def add_message(message)
      @log << message
    end
  end

end
