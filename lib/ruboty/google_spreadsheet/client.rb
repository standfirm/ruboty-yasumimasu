# frozen_string_literal: true

module Ruboty
  module GoogleSpreadsheet
    class Client
      SCOPE = 'https://www.googleapis.com/auth/drive'

      def initialize(attrs = {})
        @authorization = api_client.authorization
        @authorization.client_id = attrs[:client_id]
        @authorization.client_secret = attrs[:client_secret]
        @authorization.scope = SCOPE
        @authorization.redirect_uri = attrs[:redirect_uri]
        @refresh_token = attrs[:refresh_token]
        authorize!
      end

      def authorize!
        @authorization.refresh_token = @refresh_token
        @authorization.fetch_access_token!
        @refresh_token = @authorization.refresh_token
      end

      def access_token
        @authorization.access_token
      end

      private

      def api_client
        @api_client ||= Google::APIClient.new(
          application_name: 'ruboty-yasumimasu',
          application_version: Ruboty::Yasumimasu::VERSION
        )
      end
    end
  end
end
