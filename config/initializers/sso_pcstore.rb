require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Sso < OmniAuth::Strategies::OAuth2

      option :name, :sso

      option :client_options, {
        site: Settings.oauth.sso_url,
        authorize_url: '/oauth/authorize'
      }

      uid { user_info['id'] }

      info do
        {
          email: user_info['email']
        }
      end

      extra do
        {
          token: access_token.to_hash
        }
      end

      def user_info
        # binding.pry
        # @user_info ||= access_token.get('http://api-pcloud.dev/api/v1/my/info').parsed
        @user_info ||= access_token.get('/api/v1/my/info').parsed
      end
    end
  end
end
