# frozen_string_literal: true

module Sonarqube
  # @private
  class API < Request
    # @private
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)
    # @private
    alias auth_token= private_token=

    # Creates a new API.
    # @raise [Error:MissingCredentials]
    def initialize(options = {})
      options = Sonarqube.options.merge(options)
      (Configuration::VALID_OPTIONS_KEYS + [:auth_token]).each do |key|
        send("#{key}=", options[key]) if options[key]
      end
      request_defaults
      self.class.headers 'User-Agent' => user_agent
    end
  end
end
