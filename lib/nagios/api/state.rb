module Nagios::API
  class State < Nagios::API::Resource
    def initialize(args = {})
      super
      
      reload
    end
    
    def reload
      self.attributes = { :data => api_client.api.query("/state") }
    end
    
    def for_host(hostname)
      data[hostname]
    end
  end
end
