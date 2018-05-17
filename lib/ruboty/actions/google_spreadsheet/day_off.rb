# frozen_string_literal: true

require 'date'

module Ruboty
  module Actions
    module GoogleSpreadsheet
      class DayOff
        def initialize(message)
          @message = message
        end

        def call
          puts '#call'
          message.reply "以下の内容で休暇連絡を受け付けました。\n```\n#{row}\n```"
        end

        private

        attr_reader :message

        def client
          @client ||= Ruboty::GoogleSpreadsheet::Client.new(
            client_id: ENV['GOOGLE_CLIENT_ID'],
            client_secret: ENV['GOOGLE_CLIENT_SECRET'],
            redirect_uri: ENV['GOOGLE_REDIRECT_URI'],
            refresh_token: ENV['GOOGLE_REFRESH_TOKEN']
          )
        end

        def data
          @data ||= Ruboty::GoogleSpreadsheet::Spreadsheet.new(
            access_token: client.access_token,
            spreadsheet_key: key
          )[0]
        end

        def key
          message[:key]
        end

        def row
          dates.size.times do |index|
            data[num_rows + 1, 1] = message.from_name.to_s
            data[num_rows, 2] = dates[index].strftime('%Y/%m/%d')
            data[num_rows, 3] = holiday_type
            data[num_rows, 4] = note
          end
          data.synchronize
          data.rows[-1 * dates.size..-1].map { |row| row.join(', ') }.join("\n")
        end

        def num_rows
          data.num_rows
        end

        def dates
          @dates = [date(message[:start_date]), date(message[:end_date])].compact
        end

        def date(date)
          Date.parse(date)
        end

        def holiday_type
          '全休'
        end

        def note
          message[:note]
        end
      end
    end
  end
end
