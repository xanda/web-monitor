module WebMonitor
  class Mailer
    def initialize(config)
      @email = config.alert_mail
      @usegmail = config.use_gmail
      @gmailuser = config.gmail_username
      @gmailpass = config.gmail_password
    end

    def send(msg)
      return unless @email
      if @usegmail
        require 'rubygems'
        require 'gmail'
        gmail = Gmail.new("#{@gmailuser}", "#{@gmailpass}")
        alert_mail = "#{@email}"
        email = gmail.generate_message do
          to alert_mail
          subject "#{msg}"
          body "#{msg}"
          add_file "web-monitor.log"
        end
        gmail.deliver(email)
      else
        system %(echo '' | mail -s "#{msg}" #{@email})
      end
    end
  end
end
