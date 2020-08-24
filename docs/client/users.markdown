---
layout: default
title: Users
nav_order: 1
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

# Users

## Create User
```ruby
user = Sonarqube.user_create('new_user', 'key_new_user' ,'secretpassword')
# => #<Sonarqube::ObjectifiedHash:46320 {hash: {"user"=>{"login"=>"login_name", "name"=>"name_user", "scmAccounts"=>[], "active"=>true, "local"=>true}}}
user.user.login
# login_name
user.user.name
# name_user
```

## Update User
```ruby
user = Sonarqube.update_user('test', { email: 'test@example.com', name: 'user test' })
# => #<Sonarqube::ObjectifiedHash:46080 {hash: {"user"=>{"login"=>"test", "name"=>"user test", "email"=>"test@example.com", "active"=>true, "local"=>true, "externalIdentity"=>"test", "externalProvider"=>"sonarqube", "groups"=>[], "scmAccounts"=>[]}}}
user.user.login
# test
user.user.name
# 'user test'
```

## Search User
```ruby
users = Sonarqube.users_search()
# => #<Sonarqube::ObjectifiedHash:46340 {hash: {"paging"=>{"pageIndex"=>1, "pageSize"=>50, "total"=>5}, "users"=>[{"login"=>"admin", "name"=>"Administrator", "active"=>true, "groups"=>["sonar-administrators", "sonar-users"], "tokensCount"=>1, "local"=>true, "externalIdentity"=>"admin", "externalProvider"=>"sonarqube", "lastConnectionDate"=>"2020-08-22T23:09:14+0000"}, {"login"=>"new_user", "name"=>"key_new_user", "active"=>true, "groups"=>["sonar-users"], "tokensCount"=>0, "local"=>true, "externalIdentity"=>"new_user", "externalProvider"=>"sonarqube"}, {"login"=>"login_name", "name"=>"name_user", "active"=>true, "groups"=>["sonar-users"], "tokensCount"=>0, "local"=>true, "externalIdentity"=>"login_name", "externalProvider"=>"sonarqube"}, {"login"=>"test3", "name"=>"test QA", "active"=>true, "groups"=>["sonar-users"], "tokensCount"=>0, "local"=>true, "externalIdentity"=>"test3", "externalProvider"=>"sonarqube"}, {"login"=>"newlogin", "name"=>"test QA", "active"=>true, "groups"=>["sonar-users"], "tokensCount"=>0, "local"=>true, "externalIdentity"=>"newlogin", "externalProvider"=>"sonarqube"}]}}
users.users.each do | user |
  puts "name: #{user.name}"
  puts "login: #{user.login}"
  puts "lastConection: #{user.lastConnectionDate}" if defined? user.lastConnectionDate
end
# name: Administrator
# login: admin
# lastConection: 2020-08-22T23:09:14+0000
# name: key_new_user
# login: new_user
# name: name_user
# login: login_name
# name: test QA
# login: test3
# name: test QA
# login: newlogin
```
## Deactivate User
```ruby
user = Sonarqube.deactivate_user('test')
# => #<Sonarqube::ObjectifiedHash:46080 {hash: {"user"=>{"login"=>"test", "name"=>"user test", "email"=>"test@example.com", "active"=>false, "local"=>true, "externalIdentity"=>"test", "externalProvider"=>"sonarqube", "groups"=>[], "scmAccounts"=>[]}}}
user.user.login
# test
user.user.active
# false
```

## Change Password User
```ruby
user = Sonarqube.change_password_user('joe', 'password')
# => #<Sonarqube::ObjectifiedHash:46080 {hash: {"user"=>{"login"=>"joe", "name"=>"joe testing", "email"=>"test@example.com", "active"=>false, "local"=>true, "externalIdentity"=>"test", "externalProvider"=>"sonarqube", "groups"=>[], "scmAccounts"=>[]}}}
user.user.login
# test
user.user.active
# true

# For own user send old_passwod
user = Sonarqube.change_password_user('admin', 'password', 'old_password')
# => #<Sonarqube::ObjectifiedHash:46080 {hash: {"user"=>{"login"=>"admin", "name"=>"Sonarqube Admin", "email"=>"admin@example.com", "active"=>false, "local"=>true, "externalIdentity"=>"test", "externalProvider"=>"sonarqube", "groups"=>[], "scmAccounts"=>[]}}}
```

## Update Login User.
```ruby
user = update_login_user(login, new_login, options = {})
# => #<Sonarqube::ObjectifiedHash:46220 {hash: {}}
user.to_hash.empty?
# => true
```