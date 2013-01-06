ENV.update YAML.load(File.read(File.expand_path('../user_pref.yml', __FILE__)))

module NexusPing
  
  class InvalidIPError < StandardError; end

  module Conf
    PLAY_STORE_BASE_URL = 'https://play.google.com/store/devices/details?id='

    NEXUS_4_8G     = 'nexus_4_8gb'
    NEXUS_4_16G    = 'nexus_4_16gb'
    
    NEXUS_7_16G    = 'nexus_7_16gb'
    NEXUS_7_32G    = 'nexus_7_32gb'
    NEXUS_7_32G_3G = 'nexus_7_32gb_hspa'

    NEXUS_10_16G   = 'nexus_10_16gb'
    NEXUS_10_32G   = 'nexus_10_32gb'

    DEVICES        = [ "NEXUS_4_8G",
                       "NEXUS_4_16G",
                       "NEXUS_7_16G",
                       "NEXUS_7_32G",
                       "NEXUS_7_32G_3G",
                       "NEXUS_10_16G",
                       "NEXUS_10_32G" ]

    NOTIFY_EMAIL   = ENV["EMAIL_TO_NOTIFY"]

    GMAIL_USER     = ENV["GMAIL_USER"]
    GMAIL_PASSWORD = ENV["GMAIL_PASSWORD"]

    def self.observed_devices
      DEVICES.select { |d| d if ENV[d] == "observed" }
    end
  end
end