class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :number
      t.string :minutes_away
      t.string :message

      t.timestamps
    end
  end
end
