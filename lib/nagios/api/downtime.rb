module Nagios::API
  class Downtime < Nagios::API::Resource
    attr_reader :api_client, :service, :host
    
    def initialize(args = {})
      @service = args.delete(:service)
      @host = args.delete(:host)
      
      args['end_time'] = Time.at(args['end_time'].to_i)
      args['start_time'] = Time.at(args['start_time'].to_i)
      args['created_at'] = Time.at(args['entry_time'].to_i)
      
      super(args)
    end
    
    def id
      downtime_id
    end
    
    def cancel
      result = api_client.api.post("/cancel_downtime/#{id}", {})
      
      raise StandardError, "Unknown response canceling downtime: #{result}" unless result == "cancelled"
      
      true
    end
  end
end