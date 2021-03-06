require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class EESoc < OmniAuth::Strategies::OAuth2
      option :name, 'eesoc'

      option :client_options, {
        :site          => 'https://eesoc.com',
        :authorize_url => '/oauth/authorize',
        :token_url     => '/oauth/access_token'
      }

      # option :auth_token_params, {
      #   :mode => :query,
      #   :param_name => 'access_token'
      # }

      uid { raw_info['username'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email'],
          :nickname => raw_info['username'],
          :description => raw_info['description']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/me').parsed
      end

      protected
        def build_access_token
          verifier = request.params['code']
          client.auth_code.get_token(
            verifier,
            {:redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true)),
            {:mode => :query, :param_name => 'access_token'}
          )
        end
    end
  end
end