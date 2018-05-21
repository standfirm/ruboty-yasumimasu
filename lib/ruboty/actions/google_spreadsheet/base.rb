require 'date'

module Ruboty
  module Actions
    module GoogleSpreadsheet
      class Base
        def initialize(message)
          @message = message
        end

        def call
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
            row_data(index)
          end
          data.synchronize
          data.rows[-1 * dates.size..-1].map { |row| row.join(', ') }.join("\n")
        end

        def row_data(index)
          data[num_rows + 1, 1] = 'reserved'
          row_data = [message.from_name, date(dates[index]), holiday_type, note]

          row_data.each_with_index do |elm, idx|
            data[num_rows, idx + 1] = elm
          end
        end

        def num_rows
          data.num_rows
        end

        def dates
          @dates = [message[:start_date], message[:end_date]].compact
        end

        def date(date)
          Date.parse(date).strftime('%Y/%m/%d')
        end

        def holiday_type
          raise NotImprementedError
        end

        def note
          message[:note]
        end
      end
    end
  end
end
