# frozen_string_literal: true

module Doorkeeper
  module GrantsAssertion
    module Devise
      module OmniAuth
        class << self
          # Reuses your current devise configuration and returns a OmniAuth hash
          # object. This allows you to share find/create methods with devise.
          # Usage:
          # resource_owner_from_assertion do
          #   auth = Doorkeeper::GrantsAssertion::Devise::OmniAuth.auth_hash(
          #     provider: params.fetch(:provider),
          #     assertion: params.fetch(:assertion)
          #   )
          #   unless auth.nil?
          #     User.find_by(facebook_id: auth['id'])
          #   end
          # end
          def auth_hash(provider:, assertion:)
            devise_config = ::Devise.omniauth_configs[provider.to_sym]
            fail("Invalid Assertion Provider") if devise_config.nil?
            oauth2_wrapper(devise_config, assertion).auth_hash
          rescue OAuth2::Error => _exception
            nil
          end

          private

          def oauth2_wrapper(devise_config, assertion)
            client_id, client_secret, client_options = devise_config.args
            Doorkeeper::GrantsAssertion::OmniAuth.oauth2_wrapper(
              strategy_class: devise_config.strategy_class,
              client_id: client_id,
              client_secret: client_secret,
              client_options: client_options,
              assertion: assertion
            )
          end
        end
      end
    end
  end
end