require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params= route_params

      @params.merge!(parse_www_encoded_form(req.query_string)) if req.query_string
      @params.merge!(parse_www_encoded_form(req.body)) if req.body
      #@params.merge!(parse_www_encoded_form(req.route_params)) if req.route_params

      #p @params
    end

    def [](key)
      @params[key.to_s] || @params[key.to_sym]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      decode = URI::decode_www_form(www_encoded_form)
      results = {}
      decode.each do |key, val|
         keys = parse_key(key)
         hash_pointer = results
        keys[0..-2].each do |key|
          hash_pointer[key] ||= Hash.new
          hash_pointer = hash_pointer[key]
        end

        hash_pointer[keys[-1]] = val
      end
      results
       #p @params

    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split("[").map{|str| str.delete("]")}
      #debugger

    end
  end
end
