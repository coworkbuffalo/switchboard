namespace :entries do
  desc "Import existing entries on twilio"
  task import: :environment do
    require 'mocha/setup'
    Twilio::REST::Messages.any_instance.stubs(:create)

    Switchboard.twilio_client.account.messages.list(page_size: 1000).each do |message|
      if message.status == "received"
        begin
          puts "Processing #{message.from} => #{message.to}: #{message.body} on #{message.date_sent}"
          member = Member.find_from_number!(message.from)
          entry = member.entries.new(original_body: message.body, created_at: message.date_sent, updated_at: message.date_sent)
          entry.save
        rescue Exception => ex
          puts "There was a problem: #{ex.message}"
        end
      end
    end
  end
end
