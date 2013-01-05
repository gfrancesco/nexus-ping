require 'nexus-ping/pinger'
require 'nexus-ping/mailer'

module NexusPing
  class Notifier

    def initialize
      @pinger = Pinger.new Conf::PLAY_STORE_BASE_URL
      @mailer = Mailer.new Conf::NOTIFY_EMAIL, Conf::GMAIL_USER, Conf::GMAIL_PASSWORD
    end

    def notify_for device
      begin
        if @pinger.ping device
          subject = "[NexusPing] Google #{device} update!"
          body = "Product #{device} is not sold out anymore!\n\n"\
                 "Time: #{Time.now}\n\n"\
                 "Link to product: #{Conf::PLAY_STORE_BASE_URL + device}"
          @mailer.mail subject, body
        else
          puts "Google #{device} not available at #{Time.now}"
        end      
      rescue InvalidIPError
        subject = "[NexusPing] invalid source IP address"
        body = "ERROR: You must run nexus-ping from a GooglePlay-Devices enabled "\
               "country: UK, Germany, France, ecc."
        @mailer.mail subject, body
      rescue Curl::Err::HostResolutionError
        puts "No connection: host resolution error"
      end
    end

  end
end