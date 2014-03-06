module Nagios::API
  # Create a new client to interact with the nagios-api server.
  #
  #  client = Nagios::API::Client.new("http://nagios-server:8181")
  #
  # Optionally set authentication credentials
  #
  #  client = Nagios::API::Client.new("http://nagios-server:8181", user: 'user', password: 'password')
  #
  class Client
    attr_reader :base_url, :options, :state
    
    def initialize(base_url, extra_args = {})
      @base_url = base_url
      @options = extra_args
    end
    
    def api
      @api ||= Nagios::API::Interface.new(options.merge(base_url: base_url))
    end
    
    def hosts
      @hosts ||= Nagios::API::Hosts.new(api_client: self)
    end
    
    def state
      @state ||= Nagios::API::State.new(api_client: self)
    end
  end
end
