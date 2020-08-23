# frozen_string_literal: true

require 'spec_helper'

describe Sonarqube::Client do
  describe '.groups' do
    before do
      stub_get('/api/user_groups/search', 'group').with(query: { 'q' => 'sonar-users' })
      @group = Sonarqube.search_groups({ 'q' => 'sonar-users' })
    end

    it 'gets the correct resource' do
      expect(a_get('/api/user_groups/search')
        .with(query: { 'q' => 'sonar-users' })).to have_been_made
    end
  end

  describe '.create_group' do
    context 'without description' do
      before do
        stub_post('/api/user_groups/create', 'group_create')
        @group = Sonarqube.create_group('Sonarqube-Group')
      end

      it 'gets the correct resource' do
        expect(a_post('/api/user_groups/create')
            .with(body: { name: 'Sonarqube-Group' })).to have_been_made
      end

      it 'returns information about a created group' do
        expect(@group.group.name).to eq('Sonarqube-Group')
      end
    end

    context 'with description' do
      before do
        stub_post('/api/user_groups/create', 'group_create_with_description')
        @group = Sonarqube.create_group('Sonarqube-Group', { description: 'Sonarqube group users' })
      end

      it 'gets the correct resource' do
        expect(a_post('/api/user_groups/create')
                 .with(body: { name: 'Sonarqube-Group',
                               description: 'Sonarqube group users' })).to have_been_made
      end

      it 'returns information about a created group' do
        expect(@group.group.name).to eq('Sonarqube-Group')
        expect(@group.group.description).to eq('Sonarqube group users')
      end
    end
  end

  describe '.delete_group' do
    before do
      stub_post('/api/user_groups/delete', 'group_delete')
      @group = Sonarqube.delete_group('Sonarqube-Group')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/user_groups/delete')
             .with(body: { name: 'Sonarqube-Group' })).to have_been_made
    end

    it 'returns information about a deleted group' do
      expect(@group.to_hash).to be_empty
    end
  end

  describe '.update_group' do
    before do
      stub_post('/api/user_groups/update', 'group_update')
      @group = Sonarqube.update_group('AXQRcKrW9pRiZzanEJ2E', { description: 'New description group' })
    end

    it 'posts to the correct resource' do
      expect(a_post('/api/user_groups/update')
             .with(body: { id: 'AXQRcKrW9pRiZzanEJ2E',
                           description: 'New description group' })).to have_been_made
    end

    it 'returns information about the group' do
      expect(@group.group.description).to eq('New description group')
    end
  end

  describe '.member_add' do
    before do
      stub_post('/api/user_groups/add_user', 'member_add')
      @member = Sonarqube.member_add('AXQRcKrW9pRiZzanEJ2E', 'test-user')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/user_groups/add_user')
             .with(body: { id: 'AXQRcKrW9pRiZzanEJ2E',
                           login: 'test-user' })).to have_been_made
    end

    it "returns information about a group's members" do
      expect(@member).to be_a Sonarqube::ObjectifiedHash
      expect(@member.to_hash).to be_empty
    end
  end

  describe '.member_remove' do
    before do
      stub_post('/api/user_groups/remove_user', 'member_remove')
      @member = Sonarqube.member_remove('AXQRcKrW9pRiZzanEJ2E', 'test-user')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/user_groups/remove_user')
             .with(body: { id: 'AXQRcKrW9pRiZzanEJ2E',
                           login: 'test-user' })).to have_been_made
    end

    it 'returns information about a group member' do
      expect(@member).to be_a Sonarqube::ObjectifiedHash
      expect(@member.to_hash).to be_empty
    end
  end

  describe '.members_list' do
    before do
      stub_get('/api/user_groups/users', 'members_list').with(query: { 'id' => 'AXQRcKrW9pRiZzanEJ2E' })
      @member = Sonarqube.members_list({ id: 'AXQRcKrW9pRiZzanEJ2E' })
    end

    it 'gets the correct resource' do
      expect(a_get('/api/user_groups/users')
             .with(query: { 'id' => 'AXQRcKrW9pRiZzanEJ2E' })).to have_been_made
    end

    it 'returns information about the edited member' do
      expect(@member).to be_a Sonarqube::ObjectifiedHash
      expect(@member.users[0].name).to eq('Administrator')
    end
  end
end
