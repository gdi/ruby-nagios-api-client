module Nagios::API
  class Services
    class NoHost < StandardError; end
    
    attr_reader :api_client
    attr_accessor :host
    
    def initialize(args = {})
      @api_client = args[:api_client]
      @host = args[:host]
    end
    
    def all
      raise NoHost unless host
      
      @services ||= api_client.api.query("/service/#{host.name}").values.collect do |service_attributes|
        Service.new(service_attributes.merge(api_client: api_client, host: host))
      end
    end
    
    def find(name)
      raise NoHost unless host
      
      all.find { |service| service.name.downcase == name.downcase }
    end
    
    def reload
      @services = nil
    end
  end
  
  class Service < Nagios::API::Resource
    def name
      service
    end
    
    def state
      return nil unless host
      
      host.state['services'][name]
    end
    
    def downtimes
      return nil unless state
      
      dts = state['downtimes'] ? state['downtimes'].values : []
      dts.collect { |dt| Nagios::API::Downtime.new(dt.merge(service: self, api_client: api_client)) }
    end
    
    # schedule_downtime arguments:
    #   author
    #   comment
    #   start_time
    #   fixed
    #   duration
    #   end_time
    def schedule_downtime(params = {})
      params = params.dup
      params[:host] = host.name
      params[:service] = name
      params[:start_time] = params[:start_time].to_i if params[:start_time]
      params[:end_time] = params[:end_time].to_i if params[:end_time]
      
      result = api_client.api.post("/schedule_downtime", params)
      
      raise StandardError, "Unknown response scheduling downtime: #{result}" unless result == "scheduled"
      
      true
    end
  end
end
