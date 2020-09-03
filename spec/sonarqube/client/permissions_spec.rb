# frozen_string_literal: true

require 'spec_helper'

describe Sonarqube::Client do
  describe '.permission_add_group' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/add_group', 'permission_add_group')
        @permission = Sonarqube.permission_add_group({ groupName: 'New-Group', permission: 'user', projectKey: 'test' })
      end

      it 'gets the correct resource' do
        body = { groupName: 'New-Group', permission: 'user', projectKey: 'test' }
        expect(a_post('/api/permissions/add_group').with(body: body)).to have_been_made
      end

      it 'returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end

  describe '.add_group_to_template' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/add_group_to_template', 'template_add_group')
        @permission = Sonarqube.add_group_to_template({ groupName: 'New-Group', permission: 'user', templateName: 'test' })
      end

      it 'gets the correct resource' do
        body = { groupName: 'New-Group', permission: 'user', templateName: 'test' }
        expect(a_post('/api/permissions/add_group_to_template').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end

  describe '.add_project_creator_to_template' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/add_project_creator_to_template', 'template_add_project_creator')
        @permission = Sonarqube.add_project_creator_to_template('user', { templateName: 'test' })
      end

      it 'gets the correct resource' do
        body = { permission: 'user', templateName: 'test' }
        expect(a_post('/api/permissions/add_project_creator_to_template').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end

  describe '.permission_add_user' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/add_user', 'permission_add_user')
        @permission = Sonarqube.permission_add_user('user', 'user', { templateName: 'test' })
      end

      it 'gets the correct resource' do
        body = { login: 'user', permission: 'user', templateName: 'test' }
        expect(a_post('/api/permissions/add_user').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end

  describe '.add_user_to_template' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/add_user_to_template', 'template_add_user')
        @permission = Sonarqube.add_user_to_template('new_user', 'user', { templateName: 'test' })
      end

      it 'gets the correct resource' do
        body = { login: 'new_user', permission: 'user', templateName: 'test' }
        expect(a_post('/api/permissions/add_user_to_template').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end

  describe '.apply_template' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/apply_template', 'apply_template')
        @permission = Sonarqube.apply_template({ projectName: 'test', templateName: 'test' })
      end

      it 'gets the correct resource' do
        body = { projectName: 'test', templateName: 'test' }
        expect(a_post('/api/permissions/apply_template').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end

  describe '.bulk_apply_template' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/bulk_apply_template', 'bulk_apply_template')
        @permission = Sonarqube.bulk_apply_template({ projectName: 'test', templateName: 'test' })
      end

      it 'gets the correct resource' do
        body = { projectName: 'test', templateName: 'test' }
        expect(a_post('/api/permissions/bulk_apply_template').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end

  describe '.create_template' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/create_template', 'create_template')
        @permission = Sonarqube.create_template('template_name', 'description', '.*\.finance\..*')
      end

      it 'gets the correct resource' do
        body = { name: 'template_name', description: 'description', projectKeyPattern: '.*\.finance\..*' }
        expect(a_post('/api/permissions/create_template').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.permissionTemplate.name).to eq('template_name')
      end
    end
  end

  describe '.delete_template' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/delete_template', 'delete_template')
        @permission = Sonarqube.delete_template({ templateName: 'template_name' })
      end

      it 'gets the correct resource' do
        body = { templateName: 'template_name' }
        expect(a_post('/api/permissions/delete_template').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end

  describe '.permission_remove_group' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/remove_group', 'permission_remove_group')
        @permission = Sonarqube.permission_remove_group({ groupName: 'New-Group', permission: 'user', projectKey: 'test' })
      end

      it 'gets the correct resource' do
        body = { groupName: 'New-Group', permission: 'user', projectKey: 'test' }
        expect(a_post('/api/permissions/remove_group').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end

  describe '.remove_group_from_template' do
    context 'when successful request' do
      before do
        stub_post('/api/permissions/remove_group_from_template', 'remove_group_from_template')
        @permission = Sonarqube.remove_group_from_template({ groupName: 'New-Group', permission: 'permission', templateName: 'test' })
      end

      it 'gets the correct resource' do
        body = { groupName: 'New-Group', permission: 'permission', templateName: 'test' }
        expect(a_post('/api/permissions/remove_group_from_template').with(body: body)).to have_been_made
      end

      it 'returns returns empty hash' do
        expect(@permission.to_hash).to be_empty
      end
    end
  end
end
