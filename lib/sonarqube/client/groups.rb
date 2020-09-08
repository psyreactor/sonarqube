# frozen_string_literal: true

class Sonarqube::Client
  # Defines methods related to groups.
  # @see https://SONAR_URL/web_api/api/user_groups
  module Groups
    # Search for user groups.
    #
    # @example
    #   Sonarqube.groups_search
    #   Sonarqube.groups_search({ ps: 3, p: 2 })
    #   Sonarqube.groups_search({ ps: 3, p: 2 , q: sonar-users})
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :f Comma-separated list of the fields to be returned in response. All the fields are returned by default.
    # @option options [Integer] :ps Page size number of projects to return per page
    # @option options [Integer] :p The page to retrieve
    # @option options [String] :q Limit search to names that contain the supplied string.
    # (Any provided options will be passed to Sonarqube. See {https://SONAR_URL/web_api/api/user_groups/search}
    # @return [Array<Sonarqube::ObjectifiedHash>]
    def search_groups(options = {})
      get('/api/user_groups/search', query: options)
    end
    alias groups_search search_groups

    # Creates a new group.
    #
    # @example
    #   Sonarqube.create_group('new-group')
    #   Sonarqube.create_group('sonarqube', { description: 'New Sonarqube project' })
    #
    # @param  [String] name (required) The name of a group.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :description Description for the new group. A group description cannot be larger than 200 characters.
    # @return [Sonarqube::ObjectifiedHash] Information about created group.
    def create_group(name, options = {})
      body = { name: name }.merge(options)
      post('/api/user_groups/create', body: body)
    end
    alias group_create create_group

    # Delete's a group.
    #
    # @example
    #   Sonarqube.delete_group('projecto')
    #
    # @param  [String] name (required) The name of a group
    # @return [Sonarqube::ObjectifiedHash] Empty hash response.
    def delete_group(name)
      post('/api/user_groups/delete', body: { name: name })
    end
    alias group_delete delete_group

    # Update group.
    #
    # @example
    #   Sonarqube.group_members('AXQRcKrW9pRiZzanEJ2E')
    #   Sonarqube.group_members('AXQRcKrW9pRiZzanEJ2E, { description: 'update group description })
    #
    # @param  [String] id (required) The ID of a group.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :description New optional description for the group. A group description cannot be larger than 200 characters. If value is not defined, then description is not changed.
    # @option options [String] :name New optional name for the group. A group name cannot be larger than 255 characters and must be unique. Value 'anyone' (whatever the case) is reserved and cannot be used. If value is empty or not defined, then name is not changed.
    # @return [Array<Sonarqube::ObjectifiedHash>]
    def update_group(id, options = {})
      post('/api/user_groups/update', body: { id: id }.merge!(options))
    end
    alias group_update update_group

    # Add a user to a group.
    #
    # @example
    #   Sonarqube.add_member('AXQRcKrW9pRiZzanEJ2E', 'test-user')
    #   Sonarqube.add_member('AXQRcKrW9pRiZzanEJ2E', 'test-user', {name: 'sonar-groups'})
    #
    # @param  [String] id (required) The id of group.
    # @param  [String] login (required) The login of user.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :name Optional name of group.
    # @return [Sonarqube::ObjectifiedHash]
    def add_member(id = nil, login = nil, options = {})
      raise ArgumentError, 'Missing required parameters' if id.nil? && login.nil?

      post('/api/user_groups/add_user', body: { id: id, login: login }.merge!(options))
    end
    alias member_add add_member

    # Remove a user to a group.
    #
    # @example
    #   Sonarqube.remove_member('AXQRcKrW9pRiZzanEJ2E', 'test-user')
    #   Sonarqube.remove_member('AXQRcKrW9pRiZzanEJ2E', 'test-user', {name: 'sonar-groups'})
    #
    # @param  [String] id (required) The id of group.
    # @param  [String] login (required) The login of user.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :name Optional name of group.
    # @return [Sonarqube::ObjectifiedHash]
    def remove_member(id = nil, login = nil, options = {})
      raise ArgumentError, 'Missing required parameters' if id.nil? && login.nil?

      post('/api/user_groups/remove_user', body: { id: id, login: login }.merge!(options))
    end
    alias member_remove remove_member

    # List members of group.
    #
    # @example
    #   Sonarqube.list_members({id: 'AXQRcKrW9pRiZzanEJ2E'})
    #   Sonarqube.list_members({name: 'sonar-groups'})
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :name (required) Name of group.
    # @option options [String] :id (required) Id of group.
    # @return [Sonarqube::ObjectifiedHash] Information about added team member.
    def list_members(options = {})
      raise ArgumentError, 'Missing required parameters' if options[:id].nil? && options[:name].nil?

      get('/api/user_groups/users', query: options)
    end

    alias members_list list_members
  end
end
