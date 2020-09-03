# frozen_string_literal: true

class Sonarqube::Client
  # Defines methods related to permissions.
  # @see https://SONAR_URL/web_api/api/permissions
  module Permissions
    # Add permission to a group.
    #
    # @example
    # Sonarqube.permissions_add_group({ groupName: 'New-Group', permission: 'user', projectKey: 'test' })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :groupId Id of group.
    # @option options [String] :groupName Name of group.
    # @option options [String] :permission Permission to asing to group. global permissions: admin, profileadmin, gateadmin, scan, provisioning |  project permissions: admin, codeviewer, issueadmin, securityhotspotadmin, scan, user
    # @option options [String] :projectId Id of project, only apply for project permissions.
    # @option options [String] :projectKey Key of project, only apply for project permissions.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/add_group}
    # @return [<Sonarqube::ObjectifiedHash>]
    def permission_add_group(options = {})
      options.transform_keys(&:to_sym)
      raise ArgumentError, 'Missing required parameters' if options[:groupId].nil? && options[:groupName].nil?

      post('/api/permissions/add_group', body: options)
    end
    alias add_group_permission permission_add_group

    # Add group to template.
    #
    # @example
    # Sonarqube.add_group_to_template({ groupName: 'New-Group', permission: 'user', templateName: 'test' })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :groupId Id of group.
    # @option options [String] :groupName Name of group.
    # @option options [String] :permission Permission to asing to group. global permissions: admin, profileadmin, gateadmin, scan, provisioning |  project permissions: admin, codeviewer, issueadmin, securityhotspotadmin, scan, user
    # @option options [String] :templateId Id of template.
    # @option options [String] :templateName Name of template.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/add_group_to_template}
    # @return [<Sonarqube::ObjectifiedHash>]
    def add_group_to_template(options = {})
      options.transform_keys(&:to_sym)
      raise ArgumentError, 'Missing required parameters' if options[:groupId].nil? && options[:groupName].nil?

      post('/api/permissions/add_group_to_template', body: options)
    end

    # Add project creator to template.
    #
    # @example
    # Sonarqube.add_project_creator_to_template('issueadmin', { templateName: 'test' })
    #
    # @param [String] :permission Permission to asing to group. global permissions: admin, profileadmin, gateadmin, scan, provisioning |  project permissions: admin, codeviewer, issueadmin, securityhotspotadmin, scan, user
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :templateId Id of template.
    # @option options [String] :templateName Name of template.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/add_project_creator_to_template}
    # @return [<Sonarqube::ObjectifiedHash>]
    def add_project_creator_to_template(permission, options = {})
      raise ArgumentError, 'Missing required parameters' if permission.nil?

      post('/api/permissions/add_project_creator_to_template', body: { permission: permission }.merge!(options))
    end

    # Add permissions to user.
    #
    # @example
    # Sonarqube.permission_add_user('new_user', 'issueadmin', { projectKey: 'test' })
    #
    # @param  [String] :login Name of login user.
    # @param  [String] :permission Permission to asing to group. global permissions: admin, profileadmin, gateadmin, scan, provisioning |  project permissions: admin, codeviewer, issueadmin, securityhotspotadmin, scan, user
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :projectId Id of project, only apply for project permissions.
    # @option options [String] :projectKey Key of project, only apply for project permissions.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/add_user}
    # @return [<Sonarqube::ObjectifiedHash>]
    def permission_add_user(login, permission, options = {})
      options.transform_keys(&:to_sym)
      raise ArgumentError, 'Missing required parameters' if login.nil? && permission.nil?

      body = { login: login, permission: permission }.merge!(options)
      post('/api/permissions/add_user', body: body)
    end
    alias add_user_permission permission_add_user

    # Add user to template.
    #
    # @example
    # Sonarqube.add_user_to_template({ 'new_user', 'issueadmin', { templateName: 'test' })
    #
    # @param  [String] :login Name of login user.
    # @param  [String] :permission Permission to asing to group. global permissions: admin, profileadmin, gateadmin, scan, provisioning |  project permissions: admin, codeviewer, issueadmin, securityhotspotadmin, scan, user.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :templateId Id of template.
    # @option options [String] :templateName Name of template.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/add_user_to_template}
    # @return [<Sonarqube::ObjectifiedHash>]
    def add_user_to_template(login, permission, options = {})
      options.transform_keys(&:to_sym)
      raise ArgumentError, 'Missing required parameters' if login.nil? && permission.nil?

      body = { login: login, permission: permission }.merge!(options)
      post('/api/permissions/add_user_to_template', body: body)
    end

    # Apply template.
    #
    # @example
    # Sonarqube.apply_template({ projectName: 'New-Group', templateName: 'test' })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :projectId Id of group.
    # @option options [String] :projectName Name of group.
    # @option options [String] :templateId Id of template.
    # @option options [String] :templateName Name of template.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/apply_template}
    # @return [<Sonarqube::ObjectifiedHash>]
    def apply_template(options = {})
      options.transform_keys(&:to_sym)

      post('/api/permissions/apply_template', body: options)
    end

    # Bulk apply template.
    #
    # @example
    # Sonarqube.bulk_apply_template({ templateName: 'test', projects: 'my_project,another_project' })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :analyzedBefore Filter the projects for which last analysis is older than the given date .
    # @option options [String] :onProvisionedOnly Filter the projects that are provisioned.
    # @option options [String] :projects Comma-separated list of project keys maximum 1000
    # @option options [String] :q serach project names that contain the supplied string and project keys that are exactly the same as the supplied string
    # @option options [String] :qualifiers Comma-separated list of component qualifiers. Filter the results with the specified qualifiers.
    # @option options [String] :templateId Id of template.
    # @option options [String] :templateName Name of template.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/bulk_apply_template}
    # @return [<Sonarqube::ObjectifiedHash>]
    def bulk_apply_template(options = {})
      options.transform_keys(&:to_sym)

      post('/api/permissions/bulk_apply_template', body: options)
    end

    # Create template.
    #
    # @example
    # Sonarqube.create_template('template_name', 'description', '.*\.finance\..*')
    #
    # @param [String] :name Name of template.
    # @param [String] :project_key_pattern Project key pattern. Must be a valid Java regular expression.
    # @param [String] :description Description of template.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/create_template}
    # @return [<Sonarqube::ObjectifiedHash>]
    def create_template(name, description, project_key_pattern)
      body = { name: name, description: description, projectKeyPattern: project_key_pattern }
      post('/api/permissions/create_template', body: body)
    end

    # Delete template.
    #
    # @example
    # Sonarqube.create_template({ templateName: 'template_name' })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :templateId Id of template.
    # @option options [String] :templateName Name of template.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/delete_template}
    # @return [<Sonarqube::ObjectifiedHash>]
    def delete_template(options = {})
      options.transform_keys(&:to_sym)
      raise ArgumentError, 'Missing required parameters' if options[:templateName].nil? && options[:templateId].nil?

      post('/api/permissions/delete_template', body: options)
    end

    # Remove permission to a group.
    #
    # @example
    # Sonarqube.permissions_add_group({ groupName: 'New-Group', permission: permission, projectKey: 'test' })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :groupId Id of group.
    # @option options [String] :groupName Name of group.
    # @option options [String] :permission Permission to asing to group. global permissions: admin, profileadmin, gateadmin, scan, provisioning |  project permissions: admin, codeviewer, issueadmin, securityhotspotadmin, scan, user
    # @option options [String] :projectId Id of project, only apply for project permissions.
    # @option options [String] :projectKey Key of project, only apply for project permissions.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/remove_group}
    # @return [<Sonarqube::ObjectifiedHash>]
    def permission_remove_group(options = {})
      options.transform_keys(&:to_sym)
      raise ArgumentError, 'Missing required parameters' if options[:groupId].nil? && options[:groupName].nil?

      post('/api/permissions/remove_group', body: options)
    end
    alias remove_group_permission permission_remove_group

    # Remove group from template.
    #
    # @example
    # Sonarqube.remove_group_from_template({ groupName: 'New-Group', permission: 'permission', templateId: 'test' })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :groupId Id of group.
    # @option options [String] :groupName Name of group.
    # @option options [String] :permission Permission to asing to group. global permissions: admin, profileadmin, gateadmin, scan, provisioning |  project permissions: admin, codeviewer, issueadmin, securityhotspotadmin, scan, user
    # @option options [String] :TemplateId Id of template.
    # @option options [String] :TemplateName Name of template.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/permissions/remove_group_from_template}
    # @return [<Sonarqube::ObjectifiedHash>]
    def remove_group_from_template(options = {})
      post('/api/permissions/remove_group_from_template', body: options)
    end
  end
end
