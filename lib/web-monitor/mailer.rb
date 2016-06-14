module WebMonitor
  class Mailer
    def initialize(config)
      @email = config.alert_mail
      @gmail = config.use_gmail
      @gmailuser = config.gmail_username
      @gmailpass = config.gmail_password
    end

    def send(msg)
      return unless @email
      if @gmail
        require 'gmail'

        gmail = Gmail.new(@gmailuser, @gmailpass)
        gmail.deliver do
          to @email
          subject "#{msg}"
          text_part do
            body "#{msg}"
          end
        end
        gmail.deliver(email)
      else
        system %(echo '' | mail -s "#{msg}" #{@email})
      end
    end
  end
end
