class ActiveRecord::Base
  mattr_accessor :shared_connections
  self.shared_connections = {}

  def self.connection
    shared_connections[connection_config[:database]] ||= begin
      retrieve_connection
    end
  end
end

module MutexLockedQuerying
  @@semaphore = Mutex.new

  def query(*)
    @@semaphore.synchronize { super }
  end
end

Mysql2::Client.prepend(MutexLockedQuerying)
