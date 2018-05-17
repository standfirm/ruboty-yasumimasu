# frozen_string_literal: true

module Ruboty
  module Handlers
    class Yasumimasu < Base
      on(
        /day off (?<key>\S+) (?<start_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})[ ]?(?<end_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})[ ]?(?<note>\S*)/i,
        name: 'day_off',
        description: 'Write day off'
      )

      def day_off(message)
        puts 'day off'
        puts message[:key]
        puts message[:start_date]
        puts message[:end_date]
        puts message[:note]

        Ruboty::Actions::GoogleSpreadsheet::DayOff.new(message).call
        Ruboty::Actions::GoogleCalendar::DayOff.new(message).call
      end
    end
  end
end
