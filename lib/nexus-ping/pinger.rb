require 'curb'

module NexusPing
  class Pinger

    def initialize base_url
      @base_url = base_url
    end

    def ping device
      http = Curl.get(@base_url + device)
      
      # Heuristic to check, in a language independent way, if 
      # 'not avaible in your country' page is returned
      raise InvalidIPError if http.body_str.size < 5000

      http.body_str =~ /sold out<\/span>/i
    end

  end
end