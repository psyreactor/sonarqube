# frozen_string_literal: true

require 'spec_helper'

describe Sonarqube::Client do
  it { is_expected.to respond_to :search_projects }

  describe '.project_search' do
    before do
      stub_get('/api/projects/search', 'projects_search')
      @projects_search = Sonarqube.projects_search
    end

    it 'gets the correct resource' do
      expect(a_get('/api/projects/search')).to have_been_made
    end

    it 'returns response of projects found' do
      expect(@projects_search).to be_a Sonarqube::ObjectifiedHash
      expect(@projects_search.components.first.name).to eq('test')
      expect(@projects_search.components.first.organization).to eq('default-organization')
    end
  end

  describe '.project_create' do
    before do
      stub_post('/api/projects/create', 'project')
      @project = Sonarqube.project_create('new_project', 'new_key', { visibility: 'private' })
    end

    it 'gets the correct resource' do
      expect(a_post('/api/projects/create')).to have_been_made
    end

    it 'returns information about a created project' do
      expect(@project.project.name).to eq('new_project')
      expect(@project.project.key).to eq('new_key')
      expect(@project.project.visibility).to eq('private')
    end
  end

  describe '.project_delete' do
    before do
      stub_post('/api/projects/delete', 'project_delete')
      @project = Sonarqube.project_delete('Sonarqube')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/projects/delete')).to have_been_made
    end

    it 'returns information about a deleted project' do
      expect(@project.to_hash).to be_empty
    end
  end

  describe '.project_update_key' do
    before do
      stub_post('/api/projects/update_key', 'project_update_key')
      @project = Sonarqube.project_update_key('old_key', 'new_key')
    end

    it 'posts to the correct resource' do
      expect(a_post('/api/projects/update_key')).to have_been_made
    end

    it 'returns information about a update project key' do
      expect(@project.to_hash).to be_empty
    end
  end

  describe '.project_update_visibility' do
    before do
      stub_post('/api/projects/update_visibility', 'project_update_visibility')
      @project_update_visibility = Sonarqube.project_update_visibility('new_project', 'public')
    end

    it 'gets the correct resource' do
      expect(a_post('/api/projects/update_visibility')).to have_been_made
    end

    it 'returns a response of projects update visibility' do
      expect(@project_update_visibility.to_hash).to be_empty
    end
  end

  describe '.projects_bulk_delete' do
    before do
      stub_post('/api/projects/bulk_delete', 'projects_bulk_delete')
      @projects_bulk_delete = Sonarqube.projects_bulk_delete({ projects: 'old_project' })
    end

    it 'gets the correct resource' do
      expect(a_post('/api/projects/bulk_delete')).to have_been_made
    end

    it 'returns a response of projects bulk delete' do
      expect(@projects_bulk_delete.to_hash).to be_empty
    end
  end
end
