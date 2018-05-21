require 'ruboty/actions/google_calendar/base'

module Ruboty
  module Actions
    module GoogleCalendar
      class DayOff < Base
        private

        def holiday_type
          '休み'
        end
      end
    end
  end
end
