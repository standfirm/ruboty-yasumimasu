# frozen_string_literal: true

module Ruboty
  module Handlers
    class Yasumimasu < Base
      on(
        %r(day off (?<key>\S+) (?<start_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})\s+(?<end_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})\s+(?<note>\S*)),
        name: 'day_off',
        description: 'Write day off'
      )

      def day_off(message)
        return unless filtered_channel?(message)
        Ruboty::Actions::GoogleSpreadsheet::DayOff.new(message).call
        Ruboty::Actions::GoogleCalendar::DayOff.new(message).call
      end

      on(
        %r(morning off (?<key>\S+) (?<start_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})\s+(?<end_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})\s+(?<note>\S*)),
        name: 'morning_off',
        description: 'Write morning off'
      )

      def morning_off(message)
        return unless filtered_channel?(message)
        Ruboty::Actions::GoogleSpreadsheet::MorningOff.new(message).call
        Ruboty::Actions::GoogleCalendar::MorningOff.new(message).call
      end

      on(
        %r(afternoon off (?<key>\S+) (?<start_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})\s+(?<end_date>\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2})\s+(?<note>\S*)),
        name: 'afternoon_off',
        description: 'Write afternoon off'
      )

      def afternoon_off(message)
        return unless filtered_channel?(message)
        Ruboty::Actions::GoogleSpreadsheet::AfternoonOff.new(message).call
        Ruboty::Actions::GoogleCalendar::AfternoonOff.new(message).call
      end

      private

      def filtered_channel?(message)
        room(message.from) =~ Regexp.new(ENV['YASUMIMASU_CHANNEL_FILTER'])
      end

      def room(from)
        channels.find { |channel| channel['id'] == from }['name']
      end

      def channels
        @channels ||= JSON.parse(open(api_channels_list).read)['channels']
      end

      def api_channels_list
        "https://slack.com/api/channels.list?token=#{ENV['RUBOTY_YASUMIMASU_SLACK_TOKEN']}"
      end
    end
  end
end
