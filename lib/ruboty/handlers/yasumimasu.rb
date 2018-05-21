# frozen_string_literal: true

module Ruboty
  module Handlers
    class Yasumimasu < Base
      on(
        %r(day off (?<key>\S+) (?<start_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})[ ]?(?<end_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})[ ]?(?<note>\S*)),
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

      on(
        %r(morning off (?<key>\S+) (?<start_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})[ ]?(?<end_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})[ ]?(?<note>\S*)),
        name: 'morning_off',
        description: 'Write morning off'
      )

      def morning_off(message)
        puts 'morning off'
        puts message[:key]
        puts message[:start_date]
        puts message[:end_date]
        puts message[:note]

        Ruboty::Actions::GoogleSpreadsheet::MorningOff.new(message).call
        Ruboty::Actions::GoogleCalendar::MorningOff.new(message).call
      end

      on(
        %r(afternoon off (?<key>\S+) (?<start_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})[ ]?(?<end_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})[ ]?(?<note>\S*)),
        name: 'afternoon_off',
        description: 'Write afternoon off'
      )

      def afternoon_off(message)
        puts 'afternoon off'
        puts message[:key]
        puts message[:start_date]
        puts message[:end_date]
        puts message[:note]

        Ruboty::Actions::GoogleSpreadsheet::AfternoonOff.new(message).call
        Ruboty::Actions::GoogleCalendar::AfternoonOff.new(message).call
      end
    end
  end
end
