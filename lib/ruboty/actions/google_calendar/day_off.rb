module Ruboty
  module Actions
    module GoogleCalendar
      class DayOff
        def initialize(message)
          @message = message
        end

        def call
          puts '#call'
          create_event
          message.reply 'カレンダーに予定を追加しました。'
        end

        private

        attr_reader :message

        def create_event
          client.create_event(
            calendar_id: ENV['GOOGLE_CALENDAR_ID'],
            summary: "#{message.from_name}#{holiday_type}",
            start_date: message[:start_date],
            end_date: message[:end_date]
          )
        end

        def holiday_type
          '休み'
        end

        def client
          @client ||= Ruboty::GoogleCalendar::Client.new(
            client_id: ENV['GOOGLE_CLIENT_ID'],
            client_secret: ENV['GOOGLE_CLIENT_SECRET'],
            redirect_uri: ENV['GOOGLE_REDIRECT_URI'],
            refresh_token: ENV['GOOGLE_REFRESH_TOKEN']
          )
        end
      end
    end
  end
end
