require 'json'
require 'curb-fu'

module Nagios::API
  class Interface
    class HTTPError < StandardError; end
    class BackendAPIError < StandardError; end
    
    attr_accessor :base_url, :username, :password, :use_cache
    
    def initialize(args = {})
      @base_url = args[:base_url]
      @username = args[:username]
      @password = args[:password]
      @use_cache = args[:use_cache]
    end
    
    def query(path)
      result = query_from_api(path)
      
      return result unless use_cache
      save_to_cache(path, result) if result
      result ||= query_from_cache(path)
    end
    
    def memcached
      @memcached ||= Memcached.new("localhost:11211")
    end
    
    def save_to_cache(path, data)
      memcached.set path, data, 0
    end
    
    def query_from_cache(path)
      memcached.get(path) rescue nil
    end
    
    def authentication_options
      !username.nil? ? { username: username, password: password } : {}
    end
    
    def post(path, params)
      args = { url: base_url + path, headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
      args.merge!(authentication_options)
      result = CurbFu.post(args, params.to_json)

      if result.success?
        data = JSON.parse(result.body)
        
        if data['success']
          return data['content']
        else
          raise BackendAPIError, data['content']
        end
      else
        raise HTTPError, "Error communicating with API server: #{result.status}"
      end
    end
    
    def query_from_api(path)
      args = { url: base_url + path, headers: { Accept: 'application/json' } }
      args.merge!(authentication_options)
      result = CurbFu.get(args)

      if result.success?
        data = JSON.parse(result.body)
        
        if data['success']
          return data['content']
        else
          raise BackendAPIError
        end
      else
        raise HTTPError, "Error communicating with API server: #{result.status}"
      end
    end
  end
end