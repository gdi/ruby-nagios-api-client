module Nagios::API
  class Hosts
    attr_reader :api_client
    
    def initialize(args = {})
      @api_client = args[:api_client]
      @host_cache = {}
    end
    
    def find(hostname)
      return @host_cache[hostname] if @host_cache.has_key?(hostname)
      
      host = Host.new(api_client.api.query("/host/#{hostname}").merge(api_client: api_client))
      @host_cache[hostname] = host
      host
    end
    
    def reload
      @host_cache = {}
    end
  end
  
  class Host < Nagios::API::Resource
    def services
      @services ||= Nagios::API::Services.new(api_client: api_client, host: self)
    end
    
    def name
      host_name
    end
    
    def state
      api_client.state.for_host(name)
    end
    
    def schedule_downtime
      # host
      # author
      # comment
      # start_time
      # fixed
      # duration
      # end_time
      # services_too
    end
  end
end
