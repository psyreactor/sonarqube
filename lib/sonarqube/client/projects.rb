# frozen_string_literal: true

class Sonarqube::Client
  # Defines methods related to projects.
  # @see https://SONAR_URL/web_api/api/projects
  module Projects
    # Search for projects by name.
    #
    # @example
    #   Sonarqube.project_search()
    #   Sonarqube.project_search({ p: 2 })
    #   Sonarqube.search_projects({ ps: 42, p: 5 })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :analyzedBefore Filter the projects for which last analysis is older than the given date
    # @option options [Boolean] :onProvisionedOnly Filter the projects that are provisioned
    # @option options [Integer] :ps Page size number of projects to return per page
    # @option options [Integer] :p The page to retrieve
    # @option options [String] :qualifiers  Filter the results with the specified qualifiers (TRK,VW,APP)
    # @option options [String] :q Limit search to component names that contain the supplied string or component keys that contain the supplied string
    # @option options [String] :projects Comma-separated list of project keys
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/projects/search}
    # @return [Array<Sonarqube::ObjectifiedHash>]
    def projects_search(options = {})
      get('/api/projects/search', query: options)
    end
    alias search_projects projects_search

    # Creates a new project.
    #
    # @example
    #   Sonarqube.create_project('sonarqube','sonarqube)
    #   Sonarqube.create_project('viking', 'ragnar' { visibility: 'private' })
    #
    # @param  [String] name The name of a project.
    # @param  [String] key The key of a project.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :visibility Visibility of a project (public or private).
    # @return [Sonarqube::ObjectifiedHash] Information about created project.
    def create_project(name, key = nil, options = {})
      key = name if key.nil?
      post('/api/projects/create', body: { name: name, project: key }.merge(options))
    end

    alias project_create create_project
    # Deletes a project.
    #
    # @example
    #   Sonarqube.delete_project(4)
    #
    # @param  [String] key The key of project.
    # @return [Sonarqube::ObjectifiedHash] Information about deleted project.
    def delete_project(key)
      post('/api/projects/delete', body: { project: key })
    end

    alias project_delete delete_project
    # Gets a list of project hooks.
    #
    # @example
    #   Sonarqube.project_update_key(42)
    #   Sonarqube.project_update_key('sonarqube')
    #
    # @param  [String] key_ori The original key of a project.
    # @param  [String] key_new The New key of a project.
    # @return [Array<Sonarqube::ObjectifiedHash>]
    def project_update_key(key_ori, key_new)
      post('/api/projects/update_key', body: { from: key_ori, to: key_new })
    end

    alias update_key_project project_update_key
    # Gets a project hook.
    #
    # @example
    #   Sonarqube.project_hook(42, 5)
    #   Sonarqube.project_hook('sonarqube', 5)
    #
    # @param  [String] project The name fo project.
    # @param  [String] visibility The visibility of a project.
    # @return [Sonarqube::ObjectifiedHash]
    def project_update_visibility(project, visibility)
      post('/api/projects/update_visibility', body: { project: project, visibility: visibility })
    end

    alias update_visibility_project project_update_visibility
    # Bulk delete projects.
    #
    # @example
    #   Sonarqube.project_bulk_delete()
    #   Sonarqube.project_bulk_delete({ p: 2 })
    #   Sonarqube.project_bulk_delete({ ps: 42, p: 5 })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :analyzedBefore Filter the projects for which last analysis is older than the given date.
    # @option options [Boolean] :onProvisionedOnly Filter the projects that are provisioned
    # @option options [String] :qualifiers  Filter the results with the specified qualifiers (TRK,VW,APP)
    # @option options [String] :q Limit search to component names that contain the supplied string or component keys that contain the supplied string
    # @option options [String] :projects Comma-separated list of project keys
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/projects/bulk_delete}
    # @return [Array<Sonarqube::ObjectifiedHash>]
    def projects_bulk_delete(options = {})
      if options[:analyzedBefore].nil? && options[:projects].nil? && options[:q].nil?
        raise ArgumentError, 'Missing required parameters'
      end

      post('/api/projects/bulk_delete', body: options)
    end

    alias delete_bulk_projects projects_bulk_delete
  end
end
