class RemindersController < ApplicationController
  skip_before_filter :verify_authenticity_token 

  def create

    # message_body 
    # should be like: '20 change the laundry'

    message_body = params["Body"]
    number = params["From"]

    message_pieces = message_body.strip.split
    minutes_away = message_pieces.first.to_i
    message = message_pieces[1, message_pieces.length].join(" ")

    puts "*"*150
    puts "in #{minutes_away} minutes, sending message: #{message} to number #{number}"
    puts "*"*150

    @reminder = Reminder.new( params.permit(:number, :minutes_away, :message) )
    @reminder.number = number
    @reminder.message = message
      
    if @reminder.save
      RemindersWorker.perform_in minutes_away.minutes, @reminder.id

      respond_to do |format|
        format.all { head :no_content }
      end
    end

  end
end
