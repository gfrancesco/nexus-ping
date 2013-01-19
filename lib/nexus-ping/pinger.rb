require 'curb'

module NexusPing
  class Pinger

    def initialize base_url
      @base_url = base_url
    end

    def available? device
      if check_stock device
        false
      else
        true
      end
    end  
    

    private

    def check_stock device
      http = Curl::Easy.new(@base_url + device) do |curl|
        curl.headers["Accept"] = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
        curl.headers["Accept-Encoding"] = 'gzip, deflate'
        curl.headers["Accept-Language"] = 'en-US,en;q=0.5'
        curl.headers["Connection"] = 'keep-alive'
        curl.headers["User-Agent"] = 'Mozilla/5.0 (X11; Linux x86_64; rv:18.0) Gecko/20100101 Firefox/18.0'
      end
      http.perform
      # Heuristic to check, in a language independent way, if 
      # 'not avaible in your country' page is returned
      raise InvalidIPError if http.body_str.size < 5000

      http.body_str =~ /sold out<\/span>/i
    end

  end
end