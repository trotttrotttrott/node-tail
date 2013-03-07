module NodeTail
  class Process

    @@id = -1

    def initialize(command)

      return if self.class.running?

      @@id = fork do
        system command
      end

      ::Process.detach(@@id)
    end

    def self.id
      @@id
    end

    def self.running?
      begin
        ::Process.getpgid(@@id)
        true
      rescue Errno::ESRCH
        false
      end
    end
  end
end
