require 'ruboty/actions/google_spreadsheet/base'

module Ruboty
  module Actions
    module GoogleSpreadsheet
      class AfternoonOff < Base
        private

        def holiday_type
          '午後休'
        end
      end
    end
  end
end
