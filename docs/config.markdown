---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
title: Configuration
nav_order: 2
---

# Configuration

## Create a connection

Before you can make a request, you must give Sonarqube your connection information.

```ruby
Sonarqube.configure do |config|
  config.endpoint       = 'https://example.net:9000' # API endpoint URL, default: ENV['SONARQUBE_API_ENDPOINT']
  config.private_token  = 'Dfrt938dSgAOWd4'          # user's private token, default: ENV['SONARQUBE_API_PRIVATE_TOKEN']
  # Optional
  # config.user_agent   = 'Custom User Agent'        # user agent, default: 'Sonarqube Ruby Gem [version]'
  # config.httparty     = { }                        # Parameters config for httparty
end
```


## SSL config disabled
```ruby
Sonarqube.configure do |config|
  config.endpoint       = 'https://example.net:9000' # API endpoint URL, default: ENV['SONARQUBE_API_ENDPOINT']
  config.private_token  = 'Dfrt938dSgAOWd4'          # user's private token, default: ENV['SONARQUBE_API_PRIVATE_TOKEN']
  # Optional
  config.user_agent     = 'Sonarqube Gem Agent'      # user agent, default: 'Sonarqube Ruby Gem [version]'
  config.httparty       = { verify: false }          # Parameters config for httparty
end
  httparty: 
)
```

All of these parameters are also configurable via the top-level Sonarqube object.

## Top-level Sonarqube Object
```ruby
# set an API endpoint
Sonarqube.endpoint = 'https://example.net:9000'
# => "https://example.net:9000"

# set a user private token
Sonarqube.private_token = 'Dfrt938dSgAOWd4'
# => "Dfrt938dSgAOWd4"
# disable ssl verify
Sonarqube.httparty = { verify: false }

# configure a proxy server
Sonarqube.http_proxy('proxyhost', 8888)
# proxy server with basic auth
Sonarqube.http_proxy('proxyhost', 8888, 'proxyuser', 'strongpasswordhere')
```

Or, if you want to be really Unixy, these parameters are all configurable via environment variables:

## Sonarqube will use these env

```
ENV['SONARQUBE_API_ENDPOINT'] = 'https://example.com:9000'
ENV['SONARQUBE_API_PRIVATE_TOKEN'] = 'Dfrt938dSgAOWd4'
ENV['SONARQUBE_API_HTTPARTY_OPTIONS'] = '{read_timeout: 60}'
```
You can also create a full Client object with hash parameters:


## object with hash parameters

```ruby
sonar = Sonarqube.client(
  endpoint: 'https://example.com:9000',
  private_token: 'Dfrt938dSgAOWd4',
  httparty: {
    headers: { 'Cookie' => 'sonarqube_canary=true' }
  }
)
# => #<Sonarqube::Client:0x00000001e62408 @endpoint="https://api.example.com", @private_token="Dfrt938dSgAOWd4", @user_agent="Sonarqube Ruby Gem 2.0.0">
```