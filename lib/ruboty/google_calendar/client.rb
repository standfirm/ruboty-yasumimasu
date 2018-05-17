# frozen_string_literal: true

module Ruboty
  module GoogleCalendar
    class Client
      AUTH_URI = 'https://accounts.google.com/o/oauth2/auth'
      SCOPE = 'https://www.googleapis.com/auth/calendar'
      TOKEN_URI = 'https://accounts.google.com/o/oauth2/token'

      def initialize(client_id: nil, client_secret: nil, redirect_uri: nil, refresh_token: nil)
        @client_id = client_id
        @client_secret = client_secret
        @redirect_uri = redirect_uri
        @refresh_token = refresh_token
        authenticate!
      end

      def list_events(calendar_id: nil)
        return unless calendar_id
        api_client.execute(
          api_method: calendar.events.list,
          parameters: {
            calendarId: calendar_id,
            singleEvents: true,
            orderBy: 'startTime',
            timeMin: Time.now.iso8601
          }
        ).data
      end

      def create_event(calendar_id: nil, start_date: nil, end_date: nil)
        return unless calendar_id
        return unless start_date

        start_date = Date.parse(start_date)
        end_date = if end_date
                     Date.parse(end_date) + 1
                   else
                     start_date + 1
                   end

        api_client.execute(
          api_method: calendar.events.insert,
          parameters: {
            calendarId: calendar_id
          },
          body: JSON.dump(
            summary: '休みますbotテスト',
            start: {
              date: start_date.iso8601,
              time_zone: 'Japan'
            },
            end: {
              date: end_date.iso8601,
              time_zone: 'Japan'
            }
          ),
          headers: {
            content_type: 'application/json'
          }
        )
      end

      private

      def api_client
        @api_client ||= begin
                          tmp_client = Google::APIClient.new(
                            application_name: 'ruboty-yasumimasu',
                            application_version: Ruboty::Yasumimasu::VERSION
                          )
                          tmp_client.authorization = authorization
                          tmp_client
                        end
      end

      def authenticate!
        api_client.authorization.fetch_access_token!
      end

      def authorization
        client_secrets.to_authorization
      end

      def client_secrets
        Google::APIClient::ClientSecrets.new(
          flow: :installed,
          installed: {
            auth_uri: AUTH_URI,
            client_id: @client_id,
            client_secret: @client_secret,
            redirect_uris: [@redirect_uri],
            refresh_token: @refresh_token,
            token_uri: TOKEN_URI
          }
        )
      end

      def calendar
        @calendar ||= api_client.discovered_api('calendar', 'v3')
      end
    end
  end
end
