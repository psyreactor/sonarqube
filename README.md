# Sonarqube

[![Build Status](https://img.shields.io/github/workflow/status/psyreactor/sonarqube/CI/master)](https://github.com/psyreactor/sonarqube/actions?query=workflow%3ARuby)
[![Inline docs](https://inch-ci.org/github/psyreactor/sonarqube.svg)](https://inch-ci.org/github/psyreactor/sonarqube)
[![Coverage Status](https://coveralls.io/repos/github/psyreactor/sonarqube/badge.svg)](https://coveralls.io/github/psyreactor/sonarqube)
[![Gem version](https://img.shields.io/gem/v/sonarqube.svg)](https://rubygems.org/gems/sonarqube)
[![License](https://img.shields.io/badge/license-BSD-red.svg)](https://github.com/psyreactor/sonarqube/blob/master/LICENSE.txt)

[website](https://psyreactor.github.io/sonarqube) |
[documentation](https://www.rubydoc.info/gems/sonarqube/frames)

Sonarqube is a Ruby wrapper and CLI for the Sonarqube API
As of version `1.2.0` this gem only supports Sonarqube 7.9.

## Installation

Install it from rubygems:

```sh
gem install sonarqube
```

Or add to a Gemfile:

```ruby
gem 'sonarqube'
# gem 'sonarqube', github: 'psyreactor/sonarqube'
```

Mac OS users can install using Homebrew (may not be the latest version):

```sh
brew install sonarqube-gem
```

## Usage

### Configuration example

```ruby
Sonarqube.configure do |config|
  config.endpoint       = 'https://example.net:9000' # API endpoint URL, default: ENV['SONARQUBE_API_ENDPOINT']
  config.private_token  = 'Dfrt938dSgAOWd4'       # user's private token, default: ENV['SONARQUBE_API_PRIVATE_TOKEN']
  # Optional
  # config.user_agent   = 'Custom User Agent'          # user agent, default: 'Sonarqube Ruby Gem [version]'
end
```

### Usage examples

```ruby
# set an API endpoint
Sonarqube.endpoint = 'https://example.net:9000'
# => "https://example.net:9000"

# set a user private token
Sonarqube.private_token = 'Dfrt938dSgAOWd4'
# => "Dfrt938dSgAOWd4"

# configure a proxy server
Sonarqube.http_proxy('proxyhost', 8888)
# proxy server with basic auth
Sonarqube.http_proxy('proxyhost', 8888, 'proxyuser', 'strongpasswordhere')
# set timeout for responses
ENV['SONARQUBE_API_HTTPARTY_OPTIONS'] = '{read_timeout: 60}'
```

### initialize a new client with custom headers
```ruby
g = Sonarqube.client(
  endpoint: 'https://example.com:9000',
  private_token: 'Dfrt938dSgAOWd4',
  httparty: {
    headers: { 'Cookie' => 'sonarqube_canary=true' }
  }
)
# => #<Sonarqube::Client:0x00000001e62408 @endpoint="https://api.example.com", @private_token="qEsq1pt6HJPaNciie3MG", @user_agent="Sonarqube Ruby Gem 2.0.0">
```

### Projects

#### Create Project
```ruby
project = Sonarqube.project_create('new_project')
# => <Sonarqube::ObjectifiedHash:46200 {hash: {"project"=>{"key"=>"new_project", "name"=>"new_project", "qualifier"=>"TRK", "visibility"=>"public"}}}
project.project.key
# => "new_project"
project.to_hash
# => {"project"=>{"key"=>"new_project", "name"=>"new_project", "qualifier"=>"TRK", "visibility"=>"public"}}
```

### Users

#### Create User
```ruby
user = Sonarqube.user_create('new_user', 'key_new_user' ,'secretpassword')
# => #<Sonarqube::ObjectifiedHash:46320 {hash: {"user"=>{"login"=>"login_name", "name"=>"name_user", "scmAccounts"=>[], "active"=>true, "local"=>true}}}
user.user.login
# login_name
user.user.name
# name_user
```


### Groups

#### Search Group
```ruby
groups = Sonarqube.search_groups({ q: 'sonar-users' })
# => #<Sonarqube::ObjectifiedHash:46520 {hash: {"paging"=>{"pageIndex"=>1, "pageSize"=>100, "total"=>1}, "groups"=>[{"uuid"=>"AXOt93S3gMZPhbn-E_O7", "name"=>"sonar-users", "description"=>"Any new users created will automatically join this group", "membersCount"=>5, "default"=>true}]}}
groups.groups.each do | group |
  puts "name: #{group.name}"
  puts "login: #{group.description}"
  puts "membersCount: #{group.membersCount}"
end
# name: sonar-users
# description: Any new users created will automatically join this group
# MembersCount: 5
```

For more information, refer to [documentation](https://www.rubydoc.info/gems/sonarqube/frames).

## Development

### With a dockerized Sonarqube instance

```shell
docker-compose up -d sonarqube # Will start the Sonarqube instance in the background (approx. 3 minutes)
```

After a while, your Sonarqube instance will be accessible on http://localhost:9000.

You can login with the admin/admin user/password.

You can now setup a personal access token here: http://localhost:9000

Once you have your token, set the variables to the correct values in the `docker.env` file.

Then, launch the tool:

```shell
docker-compose run app
```

```ruby
Sonarqube.users
=> [#<Sonarqube::ObjectifiedHash:47231290771040 {hash: {"id"=>1, "name"=>"Administrator", "username"=>"root", ...]
```

To launch the specs:

```shell
docker-compose run app rake spec
```


### With an external Sonarqube instance

First, set the variables to the correct values in the `docker.env` file.

Then, launch the tool:

```shell
docker-compose run app
```

```ruby
Sonarqube.users
=> [#<Sonarqube::ObjectifiedHash:47231290771040 {hash: {"id"=>1, "name"=>"Administrator", "username"=>"root", ...]
```

To launch the specs,

```shell
docker-compose run app rake spec
```

For more information see [CONTRIBUTING.md](https://github.com/psyreactor/sonarqube/blob/master/CONTRIBUTING.md).

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.
