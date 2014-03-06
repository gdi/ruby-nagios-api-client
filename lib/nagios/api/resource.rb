module Nagios::API
  class Resource
    attr_reader :api_client
    attr_accessor :attributes
    
    def initialize(args = {})
      @api_client = args.delete(:api_client)
      @attributes = {}
      self.attributes = args
    end

    def attributes=(args = {})
      args ||= {}
      args.each do |key, value|
        self.send(:"#{key}=", value)
      end
    end
    
    def method_missing(meth, *args, &block)
      if meth.to_s =~ /^(.+)=$/
        @attributes[$1.to_sym] = args[0]
      elsif @attributes.has_key?(meth)
        @attributes[meth]
      else
        super # You *must* call super if you don't handle the
              # method, otherwise you'll mess up Ruby's method
              # lookup.
      end
    end
    
    def to_hash(options = {})
      hash = attributes
      hash.reject! { |key, value| options[:except].include?(key.to_sym) || options[:except].include?(key.to_s) } if options[:except]
      hash.reject! { |key, value| !options[:only].include?(key.to_sym) && !options[:only].include?(key.to_s) } if options[:only]
      hash
    end
  end
end
