require 'pony'

module NexusPing
  class Mailer

    attr_accessor :mail, :user, :pwd

    def initialize mail, user, pwd
      @mail = mail
      @user = user
      @pwd = pwd
    end
 
    def mail subject, body
      Pony.mail(
        :to          => @mail, 
        :subject     => subject,
        :body        => body, 
        :via         => :smtp, 
        :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => @user,
          :password             => @pwd,
          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
          :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
        }
      )
    end

  end
end