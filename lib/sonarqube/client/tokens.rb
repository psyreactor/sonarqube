# frozen_string_literal: true

class Sonarqube::Client
  # Defines methods related to tokens.
  # @see https://SONAR_URL/web_api/api/user_tokens
  module Tokens
    # Create token for user.
    #
    # @example
    #   Sonarqube.create_token('name_token')
    #   Sonarqube.create_token('name_token', 'login_name')
    #
    # @param  [String] name (required) Token name.
    # @param  [String] login (optional) Login user name.
    # @return [Sonarqube::ObjectifiedHash]
    def create_token(name, login = nil)
      raise ArgumentError, 'Missing required parameters' if name.nil?

      body = { name: name }
      body = { login: login }.merge!(body) unless login.nil?
      post('/api/user_tokens/generate', body: body)
    end
    alias token_create create_token

    # Revoke a token.
    #
    # @example
    #   Sonarqube.revoke_token('new-group')
    #   Sonarqube.revoke_token('sonarqube', { description: 'New Sonarqube project' })
    #
    # @param  [String] name (required) Token name.
    # @param  [String] login (optional) Login user name.
    # @return [Sonarqube::ObjectifiedHash] Empty hash response.
    def revoke_token(name, login = nil)
      raise ArgumentError, 'Missing required parameters' if name.nil?

      body = { name: name }
      body = { login: login }.merge!(body) unless login.nil?
      post('/api/user_tokens/revoke', body: body)
    end
    alias token_revoke revoke_token

    # List token for user.
    #
    # @example
    #   Sonarqube.list_token('login')
    #
    # @param  [String] login (required) The login name of user
    # @return [Sonarqube::ObjectifiedHash].
    def list_tokens(login)
      raise ArgumentError, 'Missing required parameters' if login.nil?

      get('/api/user_tokens/search', query: { login: login })
    end
    alias tokens_list list_tokens
  end
end
