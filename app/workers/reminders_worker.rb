class RemindersWorker
  include Sidekiq::Worker
  require 'sms_notifier'
  
  def perform reminder_id
    reminder = Reminder.find reminder_id
    SmsNotifier.send_sms reminder.message, reminder.number
    reminder.update_attribute :state, 'complete'
  end

end