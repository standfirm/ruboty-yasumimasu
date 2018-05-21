require 'ruboty/actions/google_spreadsheet/base'

module Ruboty
  module Actions
    module GoogleSpreadsheet
      class MorningOff < Base
        private

        def holiday_type
          '午前休'
        end
      end
    end
  end
end
