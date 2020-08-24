# frozen_string_literal: true

class Sonarqube::Client
  # Defines methods related to users.
  # @see https://SONAR_URL/web_api/api/users
  module Users
    # Gets a list of users.
    #
    # @example
    #   Sonarqube.users_search()
    #   Sonarqube.users_search(query: { p: 1, ps: 10 })
    #   Sonarqube.users_search(query: { p: 1, ps: 10, q: 'sonarqube' })
    #
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :ps Page size number of users to return per page
    # @option options [Integer] :p The page to retrieve
    # @option options [String] :q Filter on login, name and email
    # @return [Array<Sonarqube::ObjectifiedHash>]
    def users_search(options = {})
      get('/api/users/search', query: options)
    end

    alias search_users users_search
    # Creates a new user.
    # Requires authentication from an admin account.
    #
    # @example
    #   Sonarqube.create_user('joe', 'joe', 'secret', , { mail: 'joe@foo.org' })
    #   or
    #   Sonarqube.create_user('joe', 'joe', 'secret')
    #
    # @param  [String] name (required) The name of a user.
    # @param  [String] login (required) The login of a user.
    # @param  [String] password (required only is local user) The password of a user.
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :email The emails of a user.
    # @option options [String] :local Specify if the user should be authenticated from SonarQube server or from an external authentication system. Password should not be set when local is set to false.
    # @option options [String] :scmAccount List of SCM accounts. To set several values, the parameter must be called once for each value.
    # @param  [Hash] options A customizable set of options.
    # @return [Sonarqube::ObjectifiedHash] Information about created user.
    def create_user(login, name, password = nil, options = {})
      body = { login: login, password: password, name: name }
      body.merge!(options)
      post('/api/users/create', body: body)
    end

    alias user_create create_user
    # Updates a user.
    #
    # @example
    #   Sonarqube.update_user('joe', { email: 'joe.smith@foo.org', name: 'Joe' })
    #
    # @param  [String] login (required) The login of a user
    # @param  [Hash] options A customizable set of options.
    # @option options [String] :email The email of a user.
    # @option options [String] :name The name of a user.
    # @option options [String] :scmAccount SCM accounts. To set several values, the parameter must be called once for each value.
    # @param  [Hash] options A customizable set of options.
    # @return [Sonarqube::ObjectifiedHash] Information about update user.
    def update_user(login, options = {})
      post('/api/users/update', body: { login: login }.merge!(options))
    end

    alias user_update update_user
    # Blocks the specified user. Available only for admin.
    #
    # @example
    #   Sonarqube.deactivate_user('login')
    #
    # @param [String] login (required) The login of a user
    # @param  [Hash] options A customizable set of options.
    def deactivate_user(login, options = {})
      post('/api/users/deactivate', body: { login: login }.merge!(options))
    end

    alias user_deactivate deactivate_user
    # Change password the specified user. Available only for admin.
    #
    # @example
    #   Sonarqube.change_password_user('joe', 'password')
    #   Sonarqube.change_password_user('admin', 'password', admin)
    #
    # @param [String] login (required) The login of a user
    # @param [String] password (required) New password for login
    # @param [String] old_password (optional) Previous password. Required when changing one's own password.
    # @param  [Hash] options A customizable set of options.
    def change_password_user(login, password, old_password = nil, options = {})
      body = { login: login, password: password }
      body = { old_password: old_password }.merge!(body) unless old_password.nil?
      post('/api/users/change_password', body: body.merge!(options))
    end

    alias user_change_password change_password_user
    # Update login user.
    #
    # @example
    #   Sonarqube.update_login_user('test', 'new_test')
    #
    # @param  [String] login (required) The login of a user
    # @param  [String] new_login (required) The new login of a user
    # @param  [Hash] options A customizable set of options.
    # @return [Sonarqube::ObjectifiedHash]
    def update_login_user(login, new_login, options = {})
      post('/api/users/update_login', body: { login: login, newLogin: new_login }.merge!(options))
    end

    alias user_update_login update_login_user
    # Lists the groups a user belongs to.
    #
    # @example
    #   Sonarqube.group_user('login')
    #
    # @param  [String] login A customizable set of options.
    # @param  [Hash] options A customizable set of options.
    # @option options [Integer] :page The page number.
    # @option options [Integer] :per_page The number of results per page.
    # @option options [String] :from The start date for paginated results.
    # @return [Array<Sonarqube::ObjectifiedHash>]
    def groups_user(login, options = {})
      get('/api/users/groups', query: { login: login }.merge!(options))
    end

    alias user_groups groups_user
  end
end
