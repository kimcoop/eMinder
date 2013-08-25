class SmsNotifier

  def self.send_sms message, number
    
    puts "+"*150
    puts "sending message: #{message} to number: #{number}"
    puts "+"*150

    begin
      sms_client.create( from: ENV['twilio_sms_from_number'], to: number, body: message )
    rescue Exception => e
       Rails.logger.info("Failed sending message to #{number}")
       Rails.logger.info(e.message)
    end
  end

  private
  def self.sms_client
    client = Twilio::REST::Client.new( ENV['twilio_account_sid'], ENV['twilio_auth_token'] )
    client.account.sms.messages
  end

end