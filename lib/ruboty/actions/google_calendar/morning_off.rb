require 'ruboty/actions/google_calendar/base'

module Ruboty
  module Actions
    module GoogleCalendar
      class MorningOff < Base
        private

        def holiday_type
          '午前休'
        end
      end
    end
  end
end
