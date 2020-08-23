# frozen_string_literal: true

require 'spec_helper'

describe Sonarqube::Client do
  describe '.users_search' do
    before do
      stub_get('/api/users/search', 'users')
      @users = Sonarqube.users_search
    end

    it 'gets the correct resource' do
      expect(a_get('/api/users/search')).to have_been_made
    end

    it 'returns a paginated response of users' do
      expect(@users).to be_a Sonarqube::ObjectifiedHash
      expect(@users.users.first.login).to eq('admin')
    end
  end

  describe '.user_create' do
    context 'when successful request' do
      before do
        stub_post('/api/users/create', 'user_create')
        @user = Sonarqube.user_create('test', 'test QA', 'secretpassword')
      end

      it 'gets the correct resource' do
        body = { login: 'test', password: 'secretpassword', name: 'test QA' }
        expect(a_post('/api/users/create').with(body: body)).to have_been_made
      end

      it 'returns information about a created user' do
        expect(@user.user.login).to eq('test')
      end
    end
  end

  describe '.user_update' do
    before do
      stub_post('/api/users/update', 'user_update').with(body: { login: 'test', description: 'Test New QA' })
      @user = Sonarqube.user_update('test', { description: 'Test New QA' })
    end

    it 'gets the correct resource' do
      expect(a_post('/api/users/update').with(body: { login: 'test', description: 'Test New QA' })).to have_been_made
    end

    it 'returns information about a update user' do
      expect(@user.user.login).to eq('test')
    end
  end

  describe '.user_deactivate' do
    before do
      stub_post('/api/users/deactivate', 'user_deactivate')
      @user = Sonarqube.user_deactivate('test')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/users/deactivate')).to have_been_made
    end

    it 'returns information about a deactivate user' do
      expect(@user.user.login).to eq('test')
    end
  end

  describe '.user_change_password' do
    before do
      stub_post('/api/users/change_password', 'user_change_password')
      @result = Sonarqube.user_change_password('test', 'newpassword')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/users/change_password')).to have_been_made
    end

    it 'returns information about a change user password' do
      expect(@result.to_hash).to be_empty
    end
  end

  describe '.user_update_login' do
    before do
      stub_post('/api/users/update_login', 'user_update_login')
      @result = Sonarqube.user_update_login('test', 'newlogin')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/users/update_login')).to have_been_made
    end

    it 'returns information about a change user login' do
      expect(@result.to_hash).to be_empty
    end
  end

  describe '.user_groups' do
    before do
      stub_get('/api/users/groups', 'user_groups').with(query: { login: 'test' })
      @result = Sonarqube.user_groups('test')
    end

    it 'gets the correct resource' do
      expect(a_get('/api/users/groups').with(query: { login: 'test' })).to have_been_made
    end

    it 'returns boolean' do
      expect(@result.groups.first.name).to eq('sonar-users')
    end
  end
end
