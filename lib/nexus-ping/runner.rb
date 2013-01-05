require 'conf'
require 'nexus-ping/notifier'

module NexusPing
  module Runner

    def self.run!
      n = Notifier.new
      Conf.observed_devices.each do |device_string| 
        device = Conf::const_get :"#{device_string}" if Conf::const_defined? :"#{device_string}"
        n.notify_for device
      end
    end

  end
end