# frozen_string_literal: true

require 'spec_helper'

describe Sonarqube::Client do
  describe '.token_create' do
    before do
      stub_post('/api/user_tokens/generate', 'token_create')
      @users = Sonarqube.token_create('token_name', 'login_name')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/user_tokens/generate')).to have_been_made
    end

    it 'returns a token users info' do
      expect(@users).to be_a Sonarqube::ObjectifiedHash
      expect(@users.name).to eq('token_name')
    end
  end

  describe '.token_revoke' do
    before do
      stub_post('/api/user_tokens/revoke', 'token_revoke')
      @user = Sonarqube.token_revoke('name_token', 'login_name')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/user_tokens/revoke')).to have_been_made
    end

    it 'returns information about a created token' do
      expect(@user.to_hash).to be_empty
    end
  end

  describe '.list_tokens' do
    before do
      stub_get('/api/user_tokens/search', 'tokens_list').with(query: { login: 'login_name' })
      @result = Sonarqube.list_tokens('login_name')
    end

    it 'gets the correct resource' do
      expect(a_get('/api/user_tokens/search').with(query: { login: 'login_name' })).to have_been_made
    end

    it 'returns array of tokens' do
      expect(@result.login).to eq('login_name')
      expect(@result.userTokens.first.name).to eq('token_service')
    end
  end
end
