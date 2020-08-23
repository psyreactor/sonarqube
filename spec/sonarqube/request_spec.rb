# frozen_string_literal: true

require 'spec_helper'

describe Sonarqube::Request do
  before do
    # Prevent tests modifying the `default_params` value from causing cross-test
    # pollution

    @request = described_class.new
  end

  it { is_expected.to respond_to :get }
  it { is_expected.to respond_to :post }
  it { is_expected.to respond_to :put }
  it { is_expected.to respond_to :delete }

  describe '.default_options' do
    it 'has default values' do
      default_options = described_class.default_options
      expect(default_options).to be_a Hash
      expect(default_options[:parser]).to be_a Proc
      expect(default_options[:format]).to eq(:json)
      expect(default_options[:headers]).to eq('Accept' => 'application/json', 'Content-Type' => 'application/x-www-form-urlencoded')
    end
  end

  describe '.parse' do
    it 'returns ObjectifiedHash' do
      body = JSON.unparse(a: 1, b: 2)
      expect(described_class.parse(body)).to be_an Sonarqube::ObjectifiedHash
      expect(described_class.parse('true')).to be true
      expect(described_class.parse('false')).to be false

      expect { described_class.parse('string') }.to raise_error(Sonarqube::Error::Parsing)
    end
  end

  describe '#request_defaults' do
    context 'when endpoint is not set' do
      it 'raises Error::MissingCredentials' do
        @request.endpoint = nil
        expect do
          @request.request_defaults
        end.to raise_error(Sonarqube::Error::MissingCredentials, 'Please set an endpoint to API')
      end
    end
  end

  describe 'HTTP request methods' do
    it 'does not overwrite headers set via HTTParty configuration' do
      @request.private_token = 'token'
      @request.endpoint = 'https://example.com'
      path = "#{@request.endpoint}/version"

      # Stub Sonarqube::Configuration
      allow(@request).to receive(:httparty).and_return(
        headers: { 'Cookie' => 'sonarqube_canary=true' }
      )

      stub_request(:get, path)
      @request.get('/version')

      expect(a_request(:get, path).with(headers: {
        'Authorization' => "Basic #{Base64.strict_encode64('token:')}",
        'Cookie' => 'sonarqube_canary=true'
      }.merge(described_class.headers))).to have_been_made
    end

    it 'does not modify options in-place' do
      options = { per_page: 10 }
      original_options = options.dup

      @request.private_token = 'token'
      @request.endpoint = 'https://example.com'

      # Stub Sonarqube::Configuration
      allow(@request).to receive(:httparty).and_return(nil)

      stub_request(:get, "#{@request.endpoint}/projects_search")
      @request.get('/projects_search', options)

      expect(options).to eq(original_options)
    end
  end

  describe '#authorization_header' do
    it 'raises MissingCredentials when auth_token and private_token are not set' do
      expect do
        @request.send(:authorization_header)
      end.to raise_error(Sonarqube::Error::MissingCredentials)
    end

    it 'sets the correct header when given a private_token' do
      @request.private_token = 'sjkahwu9827u2jw'
      expect(@request.send(:authorization_header)).to eq('Authorization' => "Basic #{Base64.encode64("#{@request.private_token}:")}")
    end
  end
end
