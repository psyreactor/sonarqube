# frozen_string_literal: true

require 'sonarqube/version'
require 'sonarqube/objectified_hash'
require 'sonarqube/configuration'
require 'sonarqube/error'
require 'sonarqube/request'
require 'sonarqube/api'
require 'sonarqube/client'

module Sonarqube
  extend Configuration

  # Alias for Sonarqube::Client.new
  #
  # @return [Sonarqube::Client]
  def self.client(options = {})
    Sonarqube::Client.new(options)
  end

  # Delegate to Sonarqube::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)

    client.send(method, *args, &block)
  end

  # Delegate to Sonarqube::Client
  def self.respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name) || super
  end

  # Delegate to HTTParty.http_proxy
  def self.http_proxy(address = nil, port = nil, username = nil, password = nil)
    Sonarqube::Request.http_proxy(address, port, username, password)
  end

  # Returns an unsorted array of available client methods.
  #
  # @return [Array<Symbol>]
  def self.actions
    hidden =
      /endpoint|private_token|auth_token|user_agent|get|post|put|\Adelete\z|validate\z|request_defaults|httparty/
    (Sonarqube::Client.instance_methods - Object.methods).reject { |e| e[hidden] }
  end
end
