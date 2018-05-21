require 'ruboty/actions/google_spreadsheet/base'

module Ruboty
  module Actions
    module GoogleSpreadsheet
      class DayOff < Base
        private

        def holiday_type
          '全休'
        end
      end
    end
  end
end
