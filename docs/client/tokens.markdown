---
layout: default
title: Tokens
nav_order: 4
parent: Client
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Tokens

## Create Token
```ruby
user = Sonarqube.token_create('token_name', 'login_user')
# => #<Sonarqube::ObjectifiedHash:46100 {hash: {"login"=>"login_name", "name"=>"token_name", "token"=>"c45bc5855603e851904f7ae5357e667b286a9fc1", "createdAt"=>"2020-08-24T23:56:41+0000"}}
user.token
# c45bc5855603e851904f7ae5357e667b286a9fc1
user.name
# token_name
```

## Revoke Token
```ruby
user = Sonarqube.token_revoke('token_name', 'login_user')
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
user.to_hash.empty?
# => true
```

## List Tokens
```ruby
users = Sonarqube.tokens_list('login_user')
# => #<Sonarqube::ObjectifiedHash:46080 {hash: {"login"=>"login_user", "userTokens"=>[{"name"=>"token_service", "createdAt"=>"2020-08-24T23:56:41+0000"}]}}
puts "login: #{user.login}"
# login: login_user
users.userTokens.each do | token |
  puts "name: #{token.name}"
end
# name: token_service
```
