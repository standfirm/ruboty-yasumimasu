require 'ruboty/actions/google_calendar/base'

module Ruboty
  module Actions
    module GoogleCalendar
      class AfternoonOff < Base
        private

        def holiday_type
          '午後休'
        end
      end
    end
  end
end
