# frozen_string_literal: true

require 'rspec'
require 'webmock/rspec'
require 'simplecov'
require 'simplecov-lcov'

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov::Formatter::LcovFormatter.config do |c|
  c.output_directory = 'coverage'
  c.lcov_file_name = 'lcov.info'
  c.single_report_path = 'coverage/lcov.info'
end
SimpleCov.start

require File.expand_path('../lib/sonarqube', __dir__)

def capture_output
  out = StringIO.new
  $stdout = out
  $stderr = out
  yield
  $stdout = STDOUT
  $stderr = STDERR
  out.string
end

def load_fixture(name)
  name, extension = name.split('.')
  File.new(File.dirname(__FILE__) + "/fixtures/#{name}.#{extension || 'json'}")
end

RSpec.configure do |config|
  config.before(:all) do
    Sonarqube.endpoint = 'https://api.example.com'
    Sonarqube.private_token = 'secret'
  end
end

%i[get post put delete].each do |method|
  define_method "stub_#{method}" do |path, fixture, status_code = 200|
    stub_request(method, "#{Sonarqube.endpoint}#{path}")
      .with(headers: { 'Authorization' => "Basic #{Base64.strict_encode64("#{Sonarqube.private_token}:")}" })
      .to_return(body: load_fixture(fixture), status: status_code)
  end

  define_method "a_#{method}" do |path|
    a_request(method, "#{Sonarqube.endpoint}#{path}")
      .with(headers: { 'Authorization' => "Basic #{Base64.strict_encode64("#{Sonarqube.private_token}:")}" })
  end
end
